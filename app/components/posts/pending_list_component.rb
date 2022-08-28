# frozen_string_literal: true

class Posts::PendingListComponent < ApplicationComponent

  def initialize(group:, members:)
    @group = group
    @members = members
  end

end
