class AdminHeaderCell < Cell::Rails
	include ConversationsHelper
	include Admin::GroupsHelper
	helper :users

	def userinfo(args)
		@user=args[:user]
		render
	end
	def messages(args)
		@user=args[:user]
		@unread_message=get_unread_messages(args[:user])
		@all_count = 0
		@unread_message.each { |var| @all_count += var['mes_num'] }
		@all_count= 99 if @all_count > 99
		render
	end
	def groups(args)
		@user=args[:user]
		@unread_message=get_group_unread_messages(args[:user])
		@all_count = 0
		@unread_message.each { |var| @all_count += var['mes_num'] }
		@all_count= 99 if @all_count > 99
		render
	end
	def notifications(args)
		@user=args[:user]
		@unread_notification=@user.notifications.un_read
		render		
	end	

end
