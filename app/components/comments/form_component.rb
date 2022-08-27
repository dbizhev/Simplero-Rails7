# frozen_string_literal: true

class Comments::FormComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(comment:)
    @comment = comment
  end

end
