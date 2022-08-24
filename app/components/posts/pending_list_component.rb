# frozen_string_literal: true

class Posts::PendingListComponent < ViewComponent::Base
  include Turbo::FramesHelper, Turbo::StreamsHelper

  def initialize(group:, members:)
    @group = group
    @members = members
  end

end
