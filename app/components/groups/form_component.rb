# frozen_string_literal: true

class Groups::FormComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(group:)
    @group = group
  end
end
