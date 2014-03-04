class AdminHeaderCell < Cell::Rails
	helper :users
	def userinfo(args)
		@user=args[:user]
		render
	end
	def messages(args)
		render
	end
	def notifications(args)
		render		
	end	

end
