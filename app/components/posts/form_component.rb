# frozen_string_literal: true

class Posts::FormComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(post:)
    @post = post
  end
end
