# frozen_string_literal: true

class Comments::ListComponent < ViewComponent::Base
  include Turbo::FramesHelper, Turbo::StreamsHelper

  def initialize(group:, post:, comments:)
    @group = group
    @post = post
    @comments = comments
  end

end
