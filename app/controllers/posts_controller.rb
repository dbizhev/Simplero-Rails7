class PostsController < ApplicationController
  before_action :active_link
  before_action :set_group, only: :index

  def index
    @members = @group.members.includes(:user)
  end

  private

  def active_link
    set_header_active_link(Header::LINK_GROUP)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
