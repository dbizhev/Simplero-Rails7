# frozen_string_literal: true

class Posts::MemeberListComponent < ApplicationComponent

  def initialize(group:, members:)
    @group = group
    @members = members
  end

end
