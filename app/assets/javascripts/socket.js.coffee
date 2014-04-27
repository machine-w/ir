jQuery ->
  window.chatController = new Chat.Controller($('#ir-body').data('uri'));

window.Chat = {}

class Chat.Controller
  headmessageTemplate: (small_message,avatar,loginname,userloginname,showname,time) ->
    html =
      """
      <li id="usermesageid-#{loginname}">
          <a href="/#{userloginname}/admin/contacts?firend=#{loginname}">
              <div class="pull-left">
                  <img src="#{avatar}" alt="user image" class="img-circle"/>
              </div>
              <h4>
                  #{showname}
                  <small class="badge bg-green">1</small>
                  <small class="badge bg-yellow"><i class="fa fa-clock-o"></i>#{time}</small>
              </h4>
              <p>#{small_message}</p>
          </a>
      </li>
      """
    $(html)

  boxmessageTemplate: (message,avatar,showname,time,userurl, doc_title= undefined,doc_summary = undefined,doc_url = undefined) ->
    html =
      """
      <div class="item">
        <img src="#{avatar}" alt="user image" class="online"/>
        <p class="message">
          <a href="#{userurl}" class="name">
            <small class="text-muted pull-right"><i class="fa fa-clock-o"></i> #{time}</small>
            #{showname}
          </a>
          #{message}
        </p>
      """
    if doc_title != undefined
      doc_info = 
        """
        <div class="attachment">
          <h4>#{doc_title}</h4>
          <p class="filename">
            #{doc_summary}
          </p>
          <div class="pull-right">
            <a class="btn btn-primary btn-sm btn-flat">Open</a>
          </div>
        </div>
        """
      html = html + doc_info
    html = html + "</div>"
    $(html)

  # userListTemplate: (userList) ->
  #   userHtml = ""
  #   for user in userList
  #     userHtml = userHtml + "<li>#{user.user_name}</li>"
  #   $(userHtml)

  constructor: (url,useWebSockets) ->
    @messageQueue = []
    @dispatcher = new WebSocketRails(url)
    #@dispatcher.on_open = @createChannel
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'channel_info', @setChannelInfo
    #@dispatcher.bind 'broadcast_info', @setBroadcastlInfo
    #$('#add_message').click @sendMessage


  setChannelInfo: (channelInfo) =>
    @username = channelInfo.channel
    #alert @username
    @channel = @dispatcher.subscribe(@username)
    @channel.bind 'user_message', @receiveMessage

  receiveMessage: (message) =>
    #alert $('#head_message_num').text()
    #alert message.source_loginname
    if $('#add_message').length == 0 || $('#add_message').data('firendloginname') != message.source_loginname
      if $('#ul_head_message').children('#usermesageid-'+message.source_loginname).length == 0
        $('#ul_head_message').append @headmessageTemplate(message.small_message,message.avatar,message.source_loginname,message.target_loginname,message.showname,message.time)
      else
        mes_li=$('#ul_head_message').children('#usermesageid-'+message.source_loginname)
        mes_li.find('p').text(message.small_message)
        mes_li.find('.bg-green').html((parseInt(mes_li.find('.bg-green').text())+1)+'')
        mes_li.find('.bg-yellow').html('<i class="fa fa-clock-o"></i>'+message.time)
      $('#head_message_num').animate({backgroundColor: '#f0ad4e'},500)
      $('#head_message_num').html((parseInt($('#head_message_num').text())+1)+'')
      $('#head_message_num').animate({backgroundColor: '#5cb85c'},500)
      $('#head_message_num2').html((parseInt($('#head_message_num2').text())+1)+'')
    else
      @dispatcher.trigger 'set_mes_readed',{con_id:message.conversation}
      @boxmessageTemplate(message.message,message.avatar,message.showname,message.time,'/'+message.source_loginname).appendTo($('#message_box')).hide().slideDown(300)
      $("#message_box").animate
        scrollTop: $("#message_box")[0].scrollHeight
      , 1000

  # sendMessage: (e) =>
  #   e.preventDefault()
  #   if !$('#add_message').hasClass('disabled')
  #     message = $('#message_content').val()
  #     firend_loginname = $('#add_message').data('firendloginname')
  #     firend_id = $('#add_message').data('firendid')
  #     @dispatcher.trigger 'firend_message', {text: message,firendloginname: firend_loginname, firendid: firend_id}, @sendSuccess, @sendFailure

  # sendSuccess: (response) =>
  #   message = $('#message_content').val()
  #   my_avatar = $('#add_message').data('myavatar')
  #   my_name = $('#add_message').data('myname')
  #   time = new Date()
  #   time_format= time.getHours() + ':' + time.getMinutes()
  #   $('#message_box').append @boxmessageTemplate(message,my_avatar,my_name,time_format)
  #   $("#message_box").animate
  #     scrollTop: $("#message_box")[0].scrollHeight
  #   , 1000
  #   $('#message_content').val('')

  # sendFailure: (response) =>
  #   Messenger().post
  #     message: response.message
  #     type: "error"
  #     showCloseButton: true

