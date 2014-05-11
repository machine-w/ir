module NotificationsHelper
	include ActionView::Helpers::TextHelper
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
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>删除目录‘#{folder.name}’"
		footer =""
		make_notification(user,title,content,footer,:del_folder)
	end
	def modify_folder_notification(user,folder)
		title = "#{user.username} 修改目录‘#{folder.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改目录‘#{folder.name}’"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{admin_folder_path(folder)}'>前往目录</a>"
		make_notification(user,title,content,footer,:modify_folder)
	end
	def add_property_notification(user,folder,property)
		title = "#{user.username} 增加目录‘#{folder.name}’属性‘#{property.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>增加目录‘<a href='#{admin_folder_path(folder)}'>#{folder.name}</a>’属性‘#{property.name}’"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{config_property_admin_folder_path(folder)}'>前往属性配置页面</a>"
		make_notification(user,title,content,footer,:add_property)
	end
	def modify_property_notification(user,folder,property)
		title = "#{user.username} 修改目录‘#{folder.name}’属性‘#{property.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改目录‘<a href='#{admin_folder_path(folder)}'>#{folder.name}</a>’属性‘#{property.name}’"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{config_property_admin_folder_path(folder)}'>前往属性配置页面</a>"
		make_notification(user,title,content,footer,:modify_property)
	end
	def del_property_notification(user,folder,property)
		title = "#{user.username} 删除目录‘#{folder.name}’属性‘#{property.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>删除目录‘<a href='#{admin_folder_path(folder)}'>#{folder.name}</a>’属性‘#{property.name}’"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{config_property_admin_folder_path(folder)}'>前往属性配置页面</a>"
		make_notification(user,title,content,footer,:del_property)
	end
	def modify_view_folder_notification(user,folder)
		title = "#{user.username} 修改目录‘#{folder.name}’视图"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改目录‘<a href='#{admin_folder_path(folder)}'>#{folder.name}</a>’视图"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{config_doc_view_admin_folder_path(folder)}'>前往目录配置页面</a>"
		make_notification(user,title,content,footer,:m_folder_view)
	end
	def modify_static_folder_notification(user,folder)
		title = "#{user.username} 修改目录‘#{folder.name}’静态属性"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改目录‘<a href='#{admin_folder_path(folder)}'>#{folder.name}</a>’静态属性"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{config_static_properties_admin_folder_path(folder)}'>前往目录配置页面</a>"
		make_notification(user,title,content,footer,:m_folder_static)
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
	def del_contact_notification(user,firend)
		title = " 我删除了好友#{firend.username}"
		content = "<a href='#{admin_user_path(user.loginname)}'>我</a>删除好友<a href='#{user_path(firend.loginname)}'>#{firend.username}</a>"
		footer ="<a class='btn btn-info btn-flat btn-xs' href='/#{user.loginname}/admin/contacts?firend=#{firend.loginname}'>重新添加其为好友</a>"
		make_notification(user,title,content,footer,:del_contact)
	end

	def add_doc_notification(user,doc)
		title = "#{user.username} 新建文档‘#{truncate(doc.title, length: 20)}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>新建文档‘#{doc.title}’"
		footer ="<a class='btn btn-primary btn-flat btn-xs' href='#{admin_document_path(doc)}'>前往文档</a>"
		make_notification(user,title,content,footer,:add_doc)
	end
	def del_doc_notification(user,doc)
		title = "#{user.username}  删除文档‘#{truncate(doc.title, length: 20)}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>删除文档‘#{doc.title}’"
		footer =""
		make_notification(user,title,content,footer,:del_doc)
	end
	def modify_doc_notification(user,doc)
		title = "#{user.username} 修改文档‘#{truncate(doc.title, length: 20)}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改文档‘#{doc.title}’"
		footer ="<a class='btn btn-primary btn-flat btn-xs' href='#{admin_document_path(doc)}'>前往文档</a>"
		make_notification(user,title,content,footer,:modify_doc)
	end
	def modify_user_notification(user)
		title = "#{user.username} 修改了个人信息"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改了个人信息"
		footer ="<a class='btn btn-primary btn-flat btn-xs' href='#{edit_user_registration_path}'>前往配置页面</a>"
		make_notification(user,title,content,footer,:modify_user)
	end
	def add_group_notification(user,group)
		title = "#{user.username} 新建群组‘#{group.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>新建群组‘#{group.name}’"
		footer ="<a class='btn btn-success btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(user,title,content,footer,:add_group)
	end
	def del_group_notification(user,group)
		title = "#{user.username}  删除群组‘#{group.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>删除群组‘#{group.name}’"
		footer =""
		make_notification(user,title,content,footer,:del_group,true)
	end
	def modify_group_notification(user,group)
		title = "#{user.username} 修改群组‘#{group.name}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改群组‘#{group.name}’"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(user,title,content,footer,:modify_group)
	end
	def add_group_member_notification(user,group,member)
		title = "#{user.username} 新建群组‘#{group.name}’成员‘#{member.user.username}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>新建群组‘#{group.name}’成员‘<a href='#{user_path(member.user.loginname)}'>#{member.user.username}</a>’"
		footer ="<a class='btn btn-success btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(user,title,content,footer,:add_group_member,true)
		title2 = "#{user.username} 添加‘我’进入群组‘#{group.name}’"
		content2 = "<a href='#{user_path(user.loginname)}'>#{user.username}</a> 添加‘<a href='#{admin_user_path(member.user.loginname)}'>我</a>’’进入群组‘#{group.name}’"
		footer2 ="<a class='btn btn-success btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(member.user,title2,content2,footer2,:group_to_me,true)
	end
	def del_group_member_notification(user,group,member)
		title = "#{user.username}  删除群组‘#{group.name}’成员‘#{member.user.username}’"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>删除群组‘#{group.name}’成员‘<a href='#{user_path(member.user.loginname)}'>#{member.user.username}</a>’"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(user,title,content,footer,:del_group_member,true)
		title2 = "#{user.username} 删除‘我’从群组‘#{group.name}’"
		content2 = "<a href='#{user_path(user.loginname)}'>#{user.username}</a> 删除‘<a href='#{admin_user_path(member.user.loginname)}'>我</a>’’从群组‘#{group.name}’"
		footer2 =""
		make_notification(member.user,title2,content2,footer2,:group_del_me,true)
	end
	def modify_group_member_notification(user,group,member)
		title = "#{user.username} 修改群组‘#{group.name}’成员‘#{member.user.username}’权限"
		content = "<a href='#{admin_user_path(user.loginname)}'>#{user.username}</a>修改群组‘#{group.name}’成员‘<a href='#{user_path(member.user.loginname)}'>#{member.user.username}</a>’权限为‘#{member.type_name}’"
		footer ="<a class='btn btn-warning btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(user,title,content,footer,:modify_group_member,true)
		title2 = "#{user.username} 修改‘我’的权限在群组‘#{group.name}’"
		content2 = "<a href='#{user_path(user.loginname)}'>#{user.username}</a> 修改‘<a href='#{admin_user_path(member.user.loginname)}'>我</a>’的权限为‘#{member.type_name}’，在群组‘#{group.name}’"
		footer2 ="<a class='btn btn-success btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(member.user,title2,content2,footer2,:group_modify_me,true)
	end
	def logout_group_notification(user,group)
		title = "#{user.username}  退出群组‘#{group.name}’"
		content = "<a href='#{user_path(user.loginname)}'>#{user.username}</a>退出群组‘#{group.name}’"
		footer =""
		footer2 ="<a class='btn btn-warning btn-flat btn-xs' href='#{admin_group_path(group)}'>前往群组</a>"
		make_notification(user,title,content,footer,:logout_group,true)
		make_notification(group.user,title,content,footer2,:logout_group,true)
	end

end
