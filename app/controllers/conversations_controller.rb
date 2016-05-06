class ConversationsController < ApplicationController
	before_action :authenticate_user!
	def index
		@conversations = Conversation.all.where('sender_id=? OR receiver_id=?',current_user,current_user)
	end

	def create
		receiver = User.all.where('email = ?', params[:receiver_email]).first
		#if the receiver is found
		if receiver
			#if the conversation doesnt existm then create new, else go to their convo.
			if Conversation.all.where('(sender_id=? and receiver_id = ?) OR (sender_id=? and receiver_id=?)',current_user,receiver ,receiver, current_user).blank?
				@conversation = Conversation.new
				@conversation.receiver_id = receiver.id
				@conversation.sender_id = current_user.id
				@conversation.message_count = 1
				#validation to false due to "user must exist" bug
				if @conversation.save(validate: false)
					@conversation.messages.create!(user_id: current_user.id, text: params[:message_to_send])
					#render plain: "created successfully"
					redirect_to root_path
				else
					@conversations = Conversation.all.where('sender_id=? OR receiver_id=?',current_user,current_user)
					render :index
				end
			else
				@conversation = Conversation.all.where('(sender_id=? and receiver_id = ?) OR (sender_id=? and receiver_id=?)',current_user,receiver ,receiver, current_user).first
				@conversation.messages.create!(user_id: current_user.id, text: params[:message_to_send])
				@conversation.message_count = @conversation.message_count + 1
				@conversation.save(validate: false)
				redirect_to @conversation
			end
		else
			redirect_to root_path , notice: "There is no user"
		end
	end
	def show
		@conversation = Conversation.find(params[:id])
	end
	def message
		@conversation = Conversation.find(params[:conversation][:conversation_id])
		@message = params[:message_to_send]
		respond_to do |format|
			format.html{redirect_to @conversation}
			format.js
		end	
	end 

end
