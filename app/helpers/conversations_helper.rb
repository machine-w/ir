module ConversationsHelper
	def get_conversation_path(master,firend)
		if Conversation.all(user_ids: [master._id,firend._id]).exists?
			user_conversation_path(master.loginname,Conversation.all(user_ids: [master._id,firend._id]).first, :format => :json)
		else
			conversation = master.conversations.build()
			conversation.users.push firend
			if conversation.save
				user_conversation_path(master.loginname,conversation, :format => :json)
			else
				#跳转到new action。此处有问题。遗留问题
				new_user_conversation_path(master.loginname)
			end
		end
		
	end
	def get_from_user(users,message)
		users.each { |u| return u if u._id == message.from_id }
	end
end
