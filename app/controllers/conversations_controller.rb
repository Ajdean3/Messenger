class ConversationsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :create]
	def index
		@conversations = Conversation.all
	end
	def create
		@conversations = Conversation.all
		@conversation = Conversation.new
		receiver = User.all.where('email = ?', params[:receiver_email]).first


		if receiver
			if Conversation.all.where('(sender_id=? and receiver_id = ?) || (sender_id=? and receiver_id=?)',current_user,receiver ,receiver, current_user).blank?

				@conversation.receiver_id = receiver.id
				@conversation.sender_id = current_user.id
				@conversation.message_count = 1
				if @conversation.save
					@conversation.messages.create!(user_id: current_user.id, text: params[:message_to_send])

					redirect_to root_path
				else
					render :index
				end
			else
				@conversation = Conversation.all.where('(sender_id=? and receiver_id = ?) || (sender_id=? and receiver_id=?)',current_user,receiver ,receiver, current_user).first
				@conversation.messages.create!(user_id: current_user.id, text: params[:message_to_send])
				@conversation.message_count = @conversation.message_count + 1
				@conversation.save
				redirect_to @conversation
			end
		else
			redirect_to root_path , notice: "There is no user"
		end
	end
	def show

		@conversation = Conversation.find(params[:id])

	end
end
