jQuery ->
  window.chatController = new Chat.Controller($('#ir-body').data('uri'));

window.Chat = {}

class Chat.Controller
  headmessageTemplate: (small_message,avatar,showname,time) ->
    html =
      """
      <li>
          <a href="#">
              <div class="pull-left">
                  <img src="#{avatar}" alt="user image" class="img-circle"/>
              </div>
              <h4>
                  #{showname}
                  <small><i class="fa fa-clock-o"></i>#{time}</small>
              </h4>
              <p>#{small_message}</p>
          </a>
      </li>
      """
    $(html)

  boxmessageTemplate: (message,avatar,showname,time, doc_title= undefined,doc_summary = undefined,doc_url = undefined) ->
    html =
      """
      <div class="item">
        <img src="#{avatar}" alt="user image" class="online"/>
        <p class="message">
          <a href="#" class="name">
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
    $('#add_message').click @sendMessage


  setChannelInfo: (channelInfo) =>
    @username = channelInfo.channel
    #alert @username
    @channel = @dispatcher.subscribe(@username)
    @channel.bind 'user_message', @receiveMessage

  receiveMessage: (message) =>
    #alert $('#head_message_num').text()
    #alert message.source_loginname
    if $('#add_message').length == 0 || $('#add_message').data('firendloginname') != message.source_loginname
      $('#ul_head_message').append @headmessageTemplate(message.small_message,message.avatar,message.showname,message.time)
      $('#head_message_num').animate({backgroundColor: '#f0ad4e'},500)
      $('#head_message_num').html((parseInt($('#head_message_num').text())+1)+'')
      $('#head_message_num').animate({backgroundColor: '#5cb85c'},500)
      $('#head_message_num2').html((parseInt($('#head_message_num2').text())+1)+'')
    else
      $('#message_box').append @boxmessageTemplate(message.message,message.avatar,message.showname,message.time)
      $("#message_box").animate
        scrollTop: $("#message_box")[0].scrollHeight
      , 1000
    
  sendMessage: (e) =>
    e.preventDefault()
    if !$('#add_message').hasClass('disabled')
      message = $('#message_content').val()
      firend_loginname = $('#add_message').data('firendloginname')
      firend_id = $('#add_message').data('firendid')
      @dispatcher.trigger 'firend_message', {text: message,firendloginname: firend_loginname, firendid: firend_id}, @sendSuccess, @sendFailure

  sendSuccess: (response) =>
    message = $('#message_content').val()
    my_avatar = $('#add_message').data('myavatar')
    my_name = $('#add_message').data('myname')
    time = new Date()
    time_format= time.getHours() + ':' + time.getMinutes()
    $('#message_box').append @boxmessageTemplate(message,my_avatar,my_name,time_format)
    $("#message_box").animate
      scrollTop: $("#message_box")[0].scrollHeight
    , 1000
    $('#message_content').val('')

  sendFailure: (response) =>
    Messenger().post
      message: response.message
      type: "error"
      showCloseButton: true

  # newMessage: (message) =>
  #   @messageQueue.push message
  #   @shiftMessageQueue() if @messageQueue.length > 15
  #   @appendMessage message

  # sendMessage: (event) =>
  #   event.preventDefault()
  #   message = $('#message').val()
  #   @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message}
  #   $('#message').val('')

  # updateUserList: (userList) =>
  #   $('#user-list').html @userListTemplate(userList)

  # updateUserInfo: (event) =>
  #   @user.user_name = $('input#user_name').val()
  #   $('#username').html @user.user_name
  #   @dispatcher.trigger 'change_username', @user.serialize()

  # appendMessage: (message) ->
  #   messageTemplate = @template(message)
  #   $('#chat').append messageTemplate
  #   messageTemplate.slideDown 140

  # shiftMessageQueue: =>
  #   @messageQueue.shift()
  #   $('#chat div.messages:first').slideDown 100, ->
  #     $(this).remove()

  # createGuestUser: =>
  #   @dispatcher.trigger 'new_channel', {}

  