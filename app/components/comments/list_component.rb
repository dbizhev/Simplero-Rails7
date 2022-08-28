# frozen_string_literal: true

class Comments::ListComponent < ApplicationComponent

  def initialize(group:, post:, comments:)
    @group = group
    @post = post
    @comments = comments
  end

end
