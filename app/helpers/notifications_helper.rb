module NotificationsHelper
	def make_notification(user,title,content,footer,type)
		user.notifications.create(title: title,content: content,footer: footer,type: type)
	end
	def add_folder_notification(user,folder)
		title = "#{user.username} 新建目录‘#{folder.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>新建目录‘#{folder.name}’"
		footer ="<a class='btn btn-success btn-flat btn-xs' href='#{admin_folder_path(folder)}'>前往目录</a>"
		make_notification(user,title,content,footer,:add_folder)
	end
	def del_folder_notification(user,folder)
		title = "#{user.username}  删除目录‘#{folder.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>新建目录‘#{folder.name}’"
		footer =""
		make_notification(user,title,content,footer,:del_folder)
	end
end
