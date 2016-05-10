# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  def speak(data)
    @current_message = Message.create!(user_id: data['user_id'], text: data['text'], conversation_id: data['conversation_id'])
    #find the conversation, and its user.
    @current_user_email = User.find(data['user_id']).email
    @receiver_email = User.find(data['receiver_id']).email
    ActionCable.server.broadcast "conversation_channel", {current_user_email: @current_user_email, current_user_id: data['user_id'], text: data['text'], short_text: data['short_text'], conversation_id: data['conversation_id'], current_message: @current_message.id, receiver_id: data['receiver_id'], receiver_email: @receiver_email }
  end
end
