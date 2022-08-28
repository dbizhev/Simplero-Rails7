# frozen_string_literal: true

class Groups::FormComponent < ApplicationComponent

  def initialize(group:)
    @group = group
  end
end
