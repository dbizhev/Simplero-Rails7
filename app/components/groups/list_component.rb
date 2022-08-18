# frozen_string_literal: true

class Groups::ListComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(groups:)
    @groups = groups
  end
end
