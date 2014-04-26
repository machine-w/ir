module ConversationsHelper
	include ActionView::Helpers::TextHelper
	def get_conversation_path(master,firend)
		if Conversation.all(user_ids: [master._id,firend._id]).exists?
			user_conversation_path(master.loginname,Conversation.all(user_ids: [master._id,firend._id]).first, :format => :json)
		else
			conversation = Conversation.all.build(users: [master,firend])
			#conversation.users.push firend
			if conversation.save
				user_conversation_path(master.loginname,conversation, :format => :json)
			else
				#跳转到new action。此处有问题。遗留问题
				new_user_conversation_path(master.loginname)
			end
		end
		
	end
	def send_realtime_message(conversation,from_user,message)
		target_user = conversation.get_other_user(from_user)
		WebsocketRails[target_user.loginname].trigger(:user_message, {:conversation => conversation._id.to_s,:source_loginname => from_user.loginname, :message => message,small_message: truncate(message, :length => 10),avatar: from_user.avatar_url('normal'),showname: from_user.username,time: Time.now.strftime("%I:%M")})
	end
	def save_message(source_id,target_id,content)
		#p "#{source_id}\n"
		if Conversation.all(user_ids: [source_id,target_id]).exists?
			conversation = Conversation.all(user_ids: [target_id,target_id]).first
		else
			conversation = Conversation.all.build()
			conversation.user_ids.push source_id
			conversation.user_ids.push target_id
		end
		conversation.messages.build(from_id: source_id,content:content)
		#p "#{source_id}\n"
		conversation.save ? conversation : nil
	end
	def get_from_user(users,message)
		#users.each { |u| return u if u._id == message.from_id }
		users[0]._id == message.from_id ? users[0] : users[1]
	end
	def get_unread_messages(user)
		result = []
		user.conversations.each do |c|
			item={}
			firend = (c.users[0] == user ? c.users[1] : c.users[0])
			item['firend'] = firend
			#p "$$$$$$#{c.messages.where(unread: true,from: firend).desc('create_at').count}$$$$$$$"
			item['mes_num'] = c.messages.where(unread: true,from: firend).desc('create_at').count
			item['last_mes'] = c.messages.where(unread: true,from: firend).desc('create_at').last
			result.push item if item['mes_num'] != 0
		end
		result
	end
	
end
