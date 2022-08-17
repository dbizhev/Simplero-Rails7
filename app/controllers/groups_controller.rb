class GroupsController < ApplicationController
  before_action :active_link

  def index
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      render turbo_stream: turbo_stream.update('groups_form_model', '')
    else
      render turbo_stream: turbo_stream.replace(@group, render_to_string(Groups::FormComponent.new(group: @group)))
    end
  end

  private

  def active_link
    set_header_active_link(Header::LINK_GROUP)
  end

  private

  def group_params
    params.require(:group).permit(:id, :name, :access)
  end
end
