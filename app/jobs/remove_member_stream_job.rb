class RemoveMemberStreamJob < ApplicationJob
  queue_as :default

  def perform(group, frame)
    Turbo::StreamsChannel.broadcast_remove_to "group_#{group.id}_joined_members_stream", target: frame
  end
end
