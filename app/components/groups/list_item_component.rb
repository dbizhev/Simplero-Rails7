# frozen_string_literal: true

class Groups::ListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(group:)
    @group = group
  end
end
