module ConversationsHelper
	include ActionView::Helpers::TextHelper
	def get_conversation(master,firend)
		if Conversation.all(user_ids: [master._id,firend._id]).exists?
			return Conversation.all(user_ids: [master._id,firend._id]).first
		else
			conversation = Conversation.all.build(users: [master,firend])
			if conversation.save
				return conversation
			else
				return nil
			end
		end
		
	end
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
		WebsocketRails[target_user.loginname].trigger(:user_message, {:conversation => conversation._id.to_s,:source_loginname => from_user.loginname, :target_loginname => target_user.loginname,:message => message,small_message: truncate(message, :length => 10),avatar: from_user.avatar_url('normal'),showname: from_user.username,time: Time.now.strftime("%H:%M")})
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
		if user
			user.conversations.each do |c|
				item={}
				firend = c.get_other_user(user)
				item['firend'] = firend
				item['mes_num'] = c.messages.where(unread: true,from: firend).count
				item['last_mes'] = c.messages.where(unread: true,from: firend).last
				result.push item if item['mes_num'] != 0
			end
		end
		result
	end
	def set_unread_messages(user)
		user.conversations.each do |c|
			c.set_readed(c.get_other_user(user))
		end
	end
	def auto_send_message(doc,user_id_array)
		if current_user
			user_id_array.each do |user_id| 
				begin
				 	firend=User.find(user_id)
				 	conversation=get_conversation(current_user,firend)
				 	if conversation
				 		content = "对您公开文档。"
				 		if conversation.messages.create(from: current_user,content: content,add_document: doc)
				 			send_realtime_message(conversation,current_user,content)
				 		end
				 	end
				 rescue	
				 	next
				 end 
				
			end
		end
	end
	
end
