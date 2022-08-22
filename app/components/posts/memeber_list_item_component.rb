# frozen_string_literal: true

class Posts::MemeberListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(group:, member:)
    @group = group
    @member = member
  end

  def show_member_remove_btn?
    @group.owner_is?(user: helpers.current_user)
  end
end
