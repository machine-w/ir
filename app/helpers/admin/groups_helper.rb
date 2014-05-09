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
			item['mes_num'] = g.group_messages.count
			item['last_mes'] = g.group_messages.last
			result.push item if item['mes_num'] != 0
		end
		result
	end
end
