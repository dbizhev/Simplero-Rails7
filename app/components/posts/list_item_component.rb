# frozen_string_literal: true

class Posts::ListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(group:, post:)
    @group = group
    @post = post
  end

end
