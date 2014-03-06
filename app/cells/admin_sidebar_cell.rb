class AdminSidebarCell < Cell::Rails
	helper :users
	def avatar(args)
		@user=args[:user]
		render
	end
	def folders(args)
		@user=args[:user]
		#@folder = args[:user].folders.build
		@folder_groups=args[:user].folder_groups.all
		@folders = args[:user].folders.where(:folder_group => nil)
		render
	end
	def tags(args)
		@user=args[:user]
		render
	end

end
