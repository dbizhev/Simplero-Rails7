# frozen_string_literal: true

class HeaderComponent < ApplicationComponent
  def initialize(active_link:)
    @active_link = active_link
  end
end
