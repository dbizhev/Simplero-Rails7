# frozen_string_literal: true

require "action_text/engine"

class ApplicationComponent < ViewComponent::Base
  include ActionText::Engine.helpers, Turbo::FramesHelper, Turbo::StreamsHelper

  private

  def main_app
    @main_app ||= Rails.application.class.routes.url_helpers
  end
end
