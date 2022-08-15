module Header
  extend ActiveSupport::Concern

  LINK_GROUP = 'LINK_GROUP'

  included do
    helper_method :set_header_active_link
    helper_method :get_header_active_link
  end

  def set_header_active_link(item = nil)
    @active_link = item
  end

  def get_header_active_link
    @active_link
  end
end