# frozen_string_literal: true

class Shared::ModelErrorComponent < ApplicationComponent
  def initialize(object:)
    @object = object
  end

end
