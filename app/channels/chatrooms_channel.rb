# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.chatrooms.each do |chatroom|
      stream_from "chatrooms:#{chatroom.id}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @chatroom = Chatroom.find(data['chatroom_id'])
    message = @chatroom.messages.create(content: data['body'], user: current_user)
    MessageRelayJob.perform_later(message)
  end
end
