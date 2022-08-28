# frozen_string_literal: true

class Comments::PostComponent < ApplicationComponent
  def initialize(post:)
    @post = post
  end

end
