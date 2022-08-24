# frozen_string_literal: true

class Posts::PendingListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(group:, member:)
    @group = group
    @member = member
  end
end
