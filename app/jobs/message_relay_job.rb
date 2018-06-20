class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    html = ApplicationController.render(partial: 'rooms/message', locals: { message: message })

    ActionCable.server.broadcast "rooms:#{message.room.id}", {
      message: html,
      room_id: message.room.id
    }
  end
end
