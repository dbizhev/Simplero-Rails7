# frozen_string_literal: true

class Posts::ListItemComponent < ApplicationComponent

  def initialize(group:, post:)
    @group = group
    @post = post
  end

end
