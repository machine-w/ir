class AdminHeaderCell < Cell::Rails
	include ConversationsHelper
	helper :users

	def userinfo(args)
		@user=args[:user]
		render
	end
	def messages(args)
		@user=args[:user]
		@unread_message=get_unread_messages(args[:user])
		#p "!!!!!!!!!!#{@unread_message.size}!!!!#{@unread_message[0]['last_mes']}!!!!!" 
		@all_count = 0
		@unread_message.each { |var| @all_count += var['mes_num'] }
		render
	end
	def groups(args)
		@user=args[:user]
		@unread_message=[]
		#p "!!!!!!!!!!#{@unread_message.size}!!!!#{@unread_message[0]['last_mes']}!!!!!" 
		@all_count = 0
		#@unread_message.each { |var| @all_count += var['mes_num'] }
		render
	end
	def notifications(args)
		@user=args[:user]
		@unread_notification=@user.notifications.un_read
		render		
	end	

end
