class SocketController < WebsocketRails::BaseController
  include ConversationsHelper
  before_filter :fix_logged_in

  def initialize_session
    #p "Session Initialized\n"
    controller_store[:online_user_count] = 0
  end
  def client_connected
    #p "a user connected\n"
    controller_store[:online_user_count] += 1
    connection_store[:channel] = WebsocketRails[@username]
    send_message :channel_info, {:channel => @username}
  end
  def client_disconnected
    #p "a user disconnected\n"
    controller_store[:online_user_count] -= 1
  end
  # def firend_message
  #   #p "#{message[:firendid]}333333333333\n"
  #   con = save_message(@userid,message[:firendid],message[:text])
  #   unless con.nil?
  #     #p "#{@userid}\n"
  #     WebsocketRails[message[:firendloginname]].trigger(:user_message, {:conversation => con._id.to_s,:source_loginname => @username, :message => message[:text],small_message: message[:text],avatar: @avatar,showname: @showname,time: Time.now.strftime("%I:%M")})
  #     trigger_success({:message => ''})
  #   else
  #     trigger_failure({:message => '保存消息失败'})
  #   end
  # end
  def set_mes_readed
    @conversation=Conversation.find(message[:con_id])
    @conversation.set_readed(@conversation.get_other_user(current_user))
  end
  def set_gmes_readed
    @group=Group.find(message[:group_id])
    @group.group_messages.desc('created_at').limit(10).each { |e| e.set_readed(current_user) }
  end
  private
  def fix_logged_in
    if user_signed_in?
      	@username = current_user.loginname
      	@avatar = current_user.avatar_url('normal')
      	@showname = current_user.username
        @userid = current_user._id
    else
    	@username = 'websocket' #如果没有登录，则用一个永远不会有人用的id
    	@avatar = ' '
    	@showname = 'guest'
      @userid = ''
    end
  end
  
end