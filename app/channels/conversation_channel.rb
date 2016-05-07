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
  	@receiver_id = Conversation.find(data['conversation_id']).receiver_id
    #find the conversation, and its user.
    @receiver_email = User.find(@receiver_id).email
    ActionCable.server.broadcast "conversation_channel", {user_email: data['user_email'], text: data['text'], conversation_id: data['conversation_id'], current_user_id: data['user_id'], receiver_id: @receiver_id, receiver_email: @receiver_email ,current_message: @current_message.id }
  	
  end
end
