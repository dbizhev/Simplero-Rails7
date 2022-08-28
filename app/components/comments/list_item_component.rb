# frozen_string_literal: true

class Comments::ListItemComponent < ApplicationComponent

  def initialize(comment:)
    @comment = comment
  end

end
