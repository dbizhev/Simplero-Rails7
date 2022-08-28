# frozen_string_literal: true

class Groups::ListComponent < ApplicationComponent

  def initialize(groups:)
    @groups = groups
  end
end
