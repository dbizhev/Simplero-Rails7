# frozen_string_literal: true

class Posts::FormComponent < ApplicationComponent

  def initialize(post:)
    @post = post
  end
end
