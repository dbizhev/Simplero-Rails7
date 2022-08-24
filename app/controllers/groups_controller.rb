class GroupsController < ApplicationController
  before_action :active_link
  before_action :set_group, only: [:join, :remove_member, :respond_join_request]

  def index
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      Turbo::StreamsChannel.broadcast_prepend_to "groups_list_items_body", html: render_to_string(Groups::ListItemComponent.new(group: @group)), target: "groups_list_items_body"

      render turbo_stream: [
        turbo_stream.update('turbo_messages', render_to_string(Shared::TurboMessageComponent.new(notice: "Group created successfully"))),
        turbo_stream.update('groups_form_model', '')
      ]
    else
      render turbo_stream: turbo_stream.replace(@group, render_to_string(Groups::FormComponent.new(group: @group)))
    end
  end

  def search
    @groups = params[:type] == "all" ? Group.all : current_user.groups
    @groups = @groups.includes(:owner, :members)
    @groups = @groups.order(updated_at: :desc)
  end

  def join
    if @group.owner.id != current_user.id
      @member = @group.members.find_or_initialize_by(user_id: current_user.id)
      @member.status = @group.access == Groups::Access::PRIVATE ? Members::Status::PENDING : Members::Status::ACCEPTED if @member.new_record?
      @member.save!
      if @group.access == Groups::Access::PRIVATE
        Turbo::StreamsChannel.broadcast_prepend_to "group_#{@group.id}_pending_members_stream", html: render_to_string(Posts::PendingListItemComponent.new(group: @group, member: @member)), target: "group_#{@group.id}_pending_members"
      end
    end
  end

  def remove_member
    if @group.owner_is?(user: current_user)
      @member = @group.members.find_by(id: params[:member_id])
      @member.destroy
      RemoveMemberStreamJob.perform_later(@group, "joined_group_#{@group.id}_member_#{@member.id}")
      render turbo_stream: turbo_stream.remove("joined_group_#{@group.id}_member_#{@member.id}")
    end
  end

  def respond_join_request
    @member = @group.members.find_by(id: params[:member_id])
    @member.update!(status: params[:status])
    if params[:status] == Members::Status::ACCEPTED
      Turbo::StreamsChannel.broadcast_prepend_to "group_#{@group.id}_joined_members_stream", html: render_to_string(Posts::MemeberListItemComponent.new(group: @group, member: @member)), target: "group_#{@group.id}_joined_members"
    end
    Turbo::StreamsChannel.broadcast_remove_to "group_#{@group.id}_pending_members_stream", html: render_to_string(Posts::PendingListItemComponent.new(group: @group, member: @member)), target: "pending_group_#{@group.id}_member_#{@member.id}"
  end

  private

  def active_link
    set_header_active_link(Header::LINK_GROUP)
  end

  def group_params
    params.require(:group).permit(:id, :name, :access)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
