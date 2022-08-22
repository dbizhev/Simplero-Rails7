class RemoveMemberStreamJob < ApplicationJob
  queue_as :default

  def perform(frame)
    Turbo::StreamsChannel.broadcast_remove_to "joined_members_stream", target: frame
  end
end
