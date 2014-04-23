class AdminHeaderCell < Cell::Rails
	include ConversationsHelper
	helper :users

	def userinfo(args)
		@user=args[:user]
		render
	end
	def messages(args)
		@unread_message=get_unread_messages(args[:user])
		#p "!!!!!!!!!!#{@unread_message.size}!!!!#{@unread_message[0]['last_mes']}!!!!!" 
		@all_count = 0
		@unread_message.each { |var| @all_count += var['mes_num'] }
		render
	end
	def notifications(args)
		render		
	end	

end
