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
	def save_message(source_id,target_id,content)
		p "#{source_id}\n"
		if Conversation.all(user_ids: [source_id,target_id]).exists?
			conversation = Conversation.all(user_ids: [target_id,target_id]).first
		else
			conversation = Conversation.all.build()
			conversation.user_ids.push source_id
			conversation.user_ids.push target_id
		end
		conversation.messages.build(from_id: source_id,content:content)
		p "#{source_id}\n"
		conversation.save ? true : false
	end
	def get_from_user(users,message)
		users.each { |u| return u if u._id == message.from_id }
	end
end
