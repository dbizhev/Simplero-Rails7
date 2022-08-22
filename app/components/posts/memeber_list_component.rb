# frozen_string_literal: true

class Posts::MemeberListComponent < ViewComponent::Base
  include Turbo::FramesHelper, Turbo::StreamsHelper

  def initialize(group:, members:)
    @group = group
    @members = members
  end

end
