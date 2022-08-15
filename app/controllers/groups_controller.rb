class GroupsController < ApplicationController
  before_action :active_link

  def index
  end

  private

  def active_link
    set_header_active_link(Header::LINK_GROUP)
  end
end
