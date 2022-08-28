# frozen_string_literal: true

class Shared::TurboMessageComponent < ApplicationComponent
  def initialize(notice: nil, alert: nil)
    @notice_msg = notice
    @alert_msg = alert
  end

end
