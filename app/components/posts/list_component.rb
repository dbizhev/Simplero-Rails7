# frozen_string_literal: true

class Posts::ListComponent < ViewComponent::Base
  include Turbo::FramesHelper, Turbo::StreamsHelper

  def initialize(group:, posts:)
    @group = group
    @posts = posts
  end
end
