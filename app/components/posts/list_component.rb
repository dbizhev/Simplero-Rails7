# frozen_string_literal: true

class Posts::ListComponent < ApplicationComponent

  def initialize(group:, posts:)
    @group = group
    @posts = posts
  end
end
