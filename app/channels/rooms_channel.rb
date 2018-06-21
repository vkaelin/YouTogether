class RoomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.rooms.each do |room|
      stream_from "rooms:#{room.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    @room = Room.find(data["room_id"])
    message = @room.messages.create(content: data["content"], user: current_user)
    MessageRelayJob.perform_later(message)
  end

  def video_controllers(data)
    logger.info("*****************************")
    logger.info(data['control'])
    logger.info("*****************************")
    @room = Room.find(data["room_id"])

    if data['control'].include? 'url:'
      logger.info("*****************************")
      logger.info('INJECT URL')
      logger.info("*****************************")
      @room.video = data['control']
      @room.save
    end

    ActionCable.server.broadcast "rooms:#{@room.id}", {
      control: data['control'],
      room_id: data['room_id']
    }
  end
end
