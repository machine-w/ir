module NotificationsHelper
	def make_notification(user,title,content,footer,type,realmes=false)
		noti=user.notifications.create(title: title,content: content,footer: footer,type: type)
		WebsocketRails[user.loginname].trigger(:user_notification, {user_loginname: user.loginname,title: title,content: content,footer: footer,type_img: noti.type_img,type_color: noti.type_color,time: noti.created_at.strftime("%k:%M"),date:noti.created_at.strftime("%Y年%m月%d日")}) if realmes
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
	def modify_folder_notification(user,folder)
		title = "#{user.username} 修改目录‘#{folder.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改目录‘#{folder.name}’"
		footer ="<a class='btn btn-success btn-flat btn-xs' href='#{admin_folder_path(folder)}'>前往目录</a>"
		make_notification(user,title,content,footer,:modify_folder)
	end
	def firend_to_me_notification(user,firend)
		title = "#{firend.username} 添加我为好友"
		content = "<a href='#{user_path(firend.loginname)}'>#{firend.username}</a>加<a href='#{admin_user_path(user.loginname)}'>我</a>为好友"
		footer ="<a class='btn btn-info btn-flat btn-xs' href='/#{user.loginname}/admin/contacts?firend=#{firend.loginname}'>添加他为好友</a>"
		make_notification(user,title,content,footer,:firend_to_me,true)
	end
	def add_contact_notification(user,firend)
		title = " 我添加#{firend.username}为好友"
		content = "<a href='#{admin_user_path(user.loginname)}'>我</a>添加<a href='#{user_path(firend.loginname)}'>#{firend.username}</a>为好友"
		footer ="<a class='btn btn-info btn-flat btn-xs' href='/#{user.loginname}/admin/contacts?firend=#{firend.loginname}'>与其聊天</a>"
		make_notification(user,title,content,footer,:add_contact)
	end
end
