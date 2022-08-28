# frozen_string_literal: true

class Comments::FormComponent < ApplicationComponent

  def initialize(comment:)
    @comment = comment
  end

end
