# frozen_string_literal: true

class Groups::FormComponent < ViewComponent::Base
  def initialize(group:)
    @group = group
  end
end
