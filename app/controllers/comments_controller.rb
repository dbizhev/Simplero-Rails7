class CommentsController < ApplicationController
  before_action :active_link
  before_action :set_group
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @post.comments.includes(post: :group)
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      Turbo::StreamsChannel.broadcast_prepend_to "group_#{@group.id}_post_#{@post.id}_comments_stream", html: render_to_string(Comments::ListItemComponent.new(comment: @comment)), target: "group_#{@group.id}_post_#{@post.id}_comments"

      render turbo_stream: [
        turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(notice: "Comment created successfully"))),
        turbo_stream.update("group_#{@group.id}_post_#{@post.id}_comment_form", render_to_string(Comments::FormComponent.new(comment: @post.comments.build)))
      ]
    else
      render turbo_stream: turbo_stream.update("group_#{@group.id}_post_#{@post.id}_comment_form", render_to_string(Comments::FormComponent.new(comment: @comment)))
    end

  end

  def edit
    render turbo_stream: turbo_stream.update("group_#{@group.id}_post_#{@post.id}_comment_#{@comment.id}", render_to_string(Comments::FormComponent.new(comment: @comment)))
  end

  def update
    if @comment.update(comment_params)
      Turbo::StreamsChannel.broadcast_update_to "group_#{@group.id}_post_#{@post.id}_comments_stream", html: render_to_string(Comments::ListItemComponent.new(comment: @comment)), target: "group_#{@group.id}_post_#{@post.id}_comment_#{@comment.id}"

      render turbo_stream: turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(notice: "Comment successfully updated")))
    else
      render turbo_stream: [
        turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(alert: "Oops, something went wrong"))),
        turbo_stream.update("group_#{@group.id}_post_#{@post.id}_comment_#{@comment.id}", render_to_string(Comments::FormComponent.new(comment: @comment)))
      ]
    end
  end

  def destroy
    if @comment.destroy
      Turbo::StreamsChannel.broadcast_update_to "group_#{@group.id}_post_#{@post.id}_comments_stream", target: "group_#{@group.id}_post_#{@post.id}_comment_#{@comment.id}"

      render turbo_stream: turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(notice: "Comment successfully deleted")))
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
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
