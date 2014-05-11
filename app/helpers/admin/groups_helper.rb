module Admin::GroupsHelper
	def send_realtime_group_message(group,from_user,message)
		group.group_members.all.each do |m|
			WebsocketRails[m.user.loginname].trigger(:group_message, {:group => group._id.to_s,:username => from_user.username,:loginname => from_user.loginname, :message => message,small_message: truncate(message, :length => 10),avatar: group.avatar_url('normal'),useravatar: from_user.avatar_url('normal'),groupname: group.name,time: Time.now.strftime("%H:%M")}) unless m.user == from_user
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
end
