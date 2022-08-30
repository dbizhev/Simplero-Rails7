class NewGroupStreamJob < ApplicationJob
  queue_as :default

  def perform(group_id, user_id)
    group = Group.find(group_id)
    current_user = User.find(user_id)

    send_broadcast(group, current_user)
    User.where.not(id: current_user.id).find_each do |u|
      send_broadcast(group, u)
    end
  end

  def send_broadcast(group, user)
    Turbo::StreamsChannel.broadcast_prepend_to "groups_list_items_stream", html: ApplicationController.render(Groups::ListItemComponent.new(group: group, user: user), layout: false), target: "#{user.id}_groups_list_items_body"
  end
end
