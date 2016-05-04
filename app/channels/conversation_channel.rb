# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	ActionCable.server.broadcast "room_channel", {user_id: data['user_id'], text: data['text'], conversation_id: data['conversation_id']}
  	Message.create!(user_id: data['user_id'], text: data['text'], conversation_id: data['conversation_id'])
  end
end
