# frozen_string_literal: true

class Shared::ModelErrorComponent < ViewComponent::Base
  def initialize(object:)
    @object = object
  end

end
