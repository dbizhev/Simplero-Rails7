# frozen_string_literal: true

class Comments::ListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(comment:)
    @comment = comment
  end

end
