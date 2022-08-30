# frozen_string_literal: true

class Groups::ListItemComponent < ApplicationComponent

  def initialize(group:, user:)
    @group = group
    @user = user
  end

  def show_join_request?
    @group.owner.id != @user.id && !@group.member_exist?(user: @user)
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
    @group.owner.id != @user.id ? @group.get_member(user: @user)&.status : "OWNER"
  end
end
