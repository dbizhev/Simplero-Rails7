# frozen_string_literal: true

class Posts::PendingListItemComponent < ApplicationComponent

  def initialize(group:, member:)
    @group = group
    @member = member
  end
end
