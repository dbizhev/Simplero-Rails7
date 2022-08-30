class PostsController < ApplicationController
  before_action :active_link
  before_action :set_group, only: [:index, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    return redirect_back fallback_location: group_posts_path, alert: "You're not member of this group!" unless @group.owner_or_valid_member?(user: current_user)

    @members = @group.members.includes(:user).where(status: Members::Status::ACCEPTED)
    @pending_members = @group.members.includes(:user).where(status: Members::Status::PENDING)
    @posts = @group.posts.includes(:member)
    @post = @group.posts.build
  end

  def create
    @post = @group.posts.build(post_params)
    @post.member = @group.members.find_by(user_id: current_user.id)

    if @post.save
      Turbo::StreamsChannel.broadcast_prepend_to "group_#{@group.id}_posts_stream", html: render_to_string(Posts::ListItemComponent.new(group: @group, post: @post)), target: "group_#{@group.id}_posts"

      render turbo_stream: [
        turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(notice: "Post created successfully"))),
        turbo_stream.update("group_#{@group.id}_post_form", render_to_string(Posts::FormComponent.new(post: @group.posts.build)))
      ]
    else
      render turbo_stream: turbo_stream.update("group_#{@group.id}_post_form", render_to_string(Posts::FormComponent.new(post: @post)))
    end
  end

  def edit
    render turbo_stream: turbo_stream.update("group_#{@group.id}_post_#{@post.id}", render_to_string(Posts::FormComponent.new(post: @post)))
  end

  def update
    if @post.update(post_params)
      Turbo::StreamsChannel.broadcast_update_to "group_#{@group.id}_posts_stream", html: render_to_string(Posts::ListItemComponent.new(group: @group, post: @post)), target: "group_#{@group.id}_post_#{@post.id}"

      render turbo_stream: turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(notice: "Post successfully updated")))
    else
      render turbo_stream: [
        turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(alert: "Oops, something went wrong"))),
        turbo_stream.update("group_#{@group.id}_post_#{@post.id}", render_to_string(Posts::FormComponent.new(post: @post)))
      ]
    end
  end

  def destroy
    if @post.destroy
      Turbo::StreamsChannel.broadcast_update_to "group_#{@group.id}_posts_stream", target: "group_#{@group.id}_post_#{@post.id}"

      render turbo_stream: turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(notice: "Post successfully deleted")))
    else
      render turbo_stream: turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(alert: "Oops, something went wrong")))
    end
  end

  private

  def active_link
    set_header_active_link(Header::LINK_GROUP)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
