class AdminSidebarCell < Cell::Rails

	def avatar(args)
		render
	end
	def folders(args)
		@user=args[:user]
		@folder = args[:user].folders.build
		@folders = args[:user].folders.all
		render
	end
	def tags(args)

	end

end
