class PostsController < ApplicationController
  before_action :active_link
  before_action :set_group, only: [:index, :create]

  def index
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

  private

  def active_link
    set_header_active_link(Header::LINK_GROUP)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
