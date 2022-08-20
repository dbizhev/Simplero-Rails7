# frozen_string_literal: true

class Groups::ListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(group:)
    @group = group
  end

  def show_join_request?
    @group.owner.id != helpers.current_user.id && !@group.member_exist?(user: helpers.current_user)
  end

  def join_request_text
    case @group.access
    when Groups::Access::OPEN
      "JOIN"
    when Groups::Access::PRIVATE
      "REQUEST TO JOIN"
    end
  end

  def join_request_status
    @group.owner.id != helpers.current_user.id ? @group.get_member(user: helpers.current_user)&.status : "OWNER"
  end
end
