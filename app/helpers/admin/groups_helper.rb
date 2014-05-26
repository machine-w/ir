module Admin::GroupsHelper
	def send_realtime_group_message(group,from_user,message)
		result={}
		group.group_members.all.each do |m|
			result={:group => group._id.to_s,:username => from_user.username,:loginname => from_user.loginname, :message => message.content,small_message: truncate(message.content, :length => 10),avatar: group.avatar_url('normal'),useravatar: from_user.avatar_url('normal'),groupname: group.name,time: Time.now.strftime("%H:%M")}
			if message.add_document
				result[:add_document_title] = message.add_document.title
				result[:add_document_content] = message.add_document.get_message_content
				result[:add_document_url] = document_path(message.add_document)
			end
			WebsocketRails[m.user.loginname].trigger(:group_message, result) unless m.user == from_user
		end  
	end
	def get_group_unread_messages(user)
		result = []
		user.my_join_groups.each do |g|
			item={}
			item['group'] = g
			unread = g.group_messages.elem_match(unreads: { user_id: user._id })
			item['mes_num'] = unread.count
			item['last_mes'] = unread.last
			result.push item if item['mes_num'] != 0
		end
		result
	end
	def set_unread_group_messages(user)
		user.my_join_groups.each do |g|
			g.group_messages.each { |e| e.set_readed(user) }
		end
	end
	def auto_send_group_message(doc,group_id_array)
		if current_user
			group_id_array.each do |group_id| 
				begin
				 	@group=Group.find(group_id)
				 	if @group.group_members.where(user: current_user).exists?
				 		content="公开文档到群组。"
				 		message=@group.group_messages.build(from: current_user,content: content,add_document: doc)
				 		@group.group_members.each { |m| message.unreads.build(user: m.user) unless m.user == current_user }
				 		if message.save
				 			send_realtime_group_message(@group,current_user,message)
				 		end
				 	end
				 rescue	
				 	next
				 end 
				
			end
		end
	end
end
