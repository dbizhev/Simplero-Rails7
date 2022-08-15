# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(active_link:)
    @active_link = active_link
  end
end
