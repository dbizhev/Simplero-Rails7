# frozen_string_literal: true

class Comments::PostComponent < ViewComponent::Base
  def initialize(post:)
    @post = post
  end

end
