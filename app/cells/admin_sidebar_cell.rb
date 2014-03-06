class AdminSidebarCell < Cell::Rails
	helper :users
	def avatar(args)
		@user=args[:user]
		render
	end
	def folders(args)
		@user=args[:user]
		#@folder = args[:user].folders.build
		@folders = args[:user].folders.all
		render
	end
	def tags(args)
		render
	end

end
