$(function() {
  $('#message_box').css('max-height', $(window).height() - 300);
  $('#contacts-list').css('max-height', $(window).height() - 300);
  //$('#add_message').addClass('disabled');
  $("#message_box").animate({
          scrollTop: $('#message_box')[0].scrollHeight
        }, 1000);
  var not_firend = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: $('#add-contacts').attr('not-firend-url') + '?q=%QUERY'
  });
  var department_not_firend = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    //remote: '/users/index.json?q=%QUERY',
    prefetch: $('#add-contacts').attr('department-not-firend-url')
    //local: $.map(states, function(state) { return { value: state }; })
  });
  var discipline_not_firend = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    //remote: '/users/index.json?q=%QUERY',
    prefetch: $('#add-contacts').attr('discipline-not-firend-url')
    //local: $.map(states, function(state) { return { value: state }; })
  });
  var in_firend = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    //remote: '/users/index.json?q=%QUERY',
    prefetch: $('#add-contacts').attr('in-firend-url')
    //local: $.map(states, function(state) { return { value: state }; })
  });

  // kicks off the loading/processing of `local` and `prefetch`
  not_firend.initialize();
  department_not_firend.initialize();
  discipline_not_firend.initialize();
  in_firend.initialize();
  delete_contact = function(url) {
    $.ajax({
      url: url,
      type: 'DELETE',
      success: function(result) {
        if (result['status'] == 'true') {
          not_firend.clearRemoteCache();
          in_firend.clearPrefetchCache();
          department_not_firend.clearPrefetchCache();
          discipline_not_firend.clearPrefetchCache();
          in_firend.initialize(true);
          department_not_firend.initialize(true);
          discipline_not_firend.initialize(true);
          $('#' + result['contact_id']).slideUp(300, function() {
            $('#' + result['contact_id']).remove();
          });

          Messenger().post({
            message: result['message'],
            type: 'success',
            showCloseButton: true
          });
        } else {
          Messenger().post({
            message: result['message'],
            type: 'error',
            showCloseButton: true
          });
        }
      }
    });
    //return false;
  };
  add_contact = function(userid) {
    $.post(
        $('#add-contacts').attr('add-contacts-url'), {
          add_id: userid
        },
        function(data) {
          if (data['status'] == 'true') {
            var template = Handlebars.compile('<li  id="{{contact_id}}" ><a href="" onclick="view_conversation(\'{{view_conversation_url}}\',\'{{contact_id}}\');return false;" data-toggle="tooltip" title="{{depart}}-{{type}}"><small class="text-muted pull-right"><button type="button" onclick="window.location.href=\'{{contact_home}}\';return false;" class="btn btn-default btn-sm"><i class="fa fa-eye text-blue"></i></button> <button type="button" onclick="delete_contact(\'{{contact_del}}\');return false;" class="btn btn-default btn-sm"><i class="fa fa-times text-red"></i></button></small><img src="{{avatar}}" class="online"><span style="font-size: 18px;font-weight: bold;color: #3c8dbc">{{username}}</span></a></li>');
            $(template({
              avatar: data['add_user']['avatar']['normal']['url'],
              username: data['add_user']['username'],
              contact_id: data['contact_id'],
              depart: data['department'],
              type: data['user_type'],
              contact_home: data['contact_home'],
              contact_del: data['contact_del'],
              view_conversation_url: data['view_conversation_url']
            })).prependTo('#contacts-list').hide().slideDown(300);
            not_firend.clearRemoteCache();
            in_firend.clearPrefetchCache();
            department_not_firend.clearPrefetchCache();
            discipline_not_firend.clearPrefetchCache();
            //not_firend.initialize(true);
            in_firend.initialize(true);
            department_not_firend.initialize(true);
            discipline_not_firend.initialize(true);
            Messenger().post({
              message: data['message'],
              type: 'success',
              showCloseButton: true
            });
            $('#' + data['contact_id'] + ' a').trigger("click");
          } else {
            Messenger().post({
              message: data['message'],
              type: 'error',
              showCloseButton: true
            });
          }
        }
      );
  };
  view_conversation = function(url, button_id) {
    $.ajax({
      url: url,
      type: 'GET',
      success: function(result) {
        $('#message_title').html('<i class="fa fa-comments-o"></i>与'+result['firend_username']+'的会话');
        $('#message_box').empty();
        $('#add_message').removeClass('disabled');
        $('#contacts-list').children().removeClass("active");
        $('#add_message').attr('add-url', url);
        $('#add_message').attr('data-firendloginname', result['firend_loginname']);
        $('#add_message').attr('data-firendid', result['firend_id']);
        $('#' + button_id).addClass("active");
        var mes = Handlebars.compile('<div class="item"><img src="{{avatar}}" alt="user image" class="online"/><p class="message"><a href="{{userurl}}" class="name"><small class="text-muted pull-right"><i class="fa fa-clock-o"></i>{{time}}</small>{{name}}</a>{{content}}</p>{{add_document}}</div>');
        $.each(result['messages'], function(index, value) {
          $('#message_box').append(mes({
            avatar: value['avatar'],
            time: value['time'],
            name: value['name'],
            userurl: '/'+value['loginname'],
            content: value['content'],
            add_document: value['add_document']
          }));
        });
        $("#message_box").animate({
          scrollTop: $('#message_box')[0].scrollHeight
        }, 1000);
        //清理消息按钮
        if ($('#ul_head_message').children('#usermesageid-'+result['firend_loginname']).length !== 0) {
          var mes_li = $('#ul_head_message').children('#usermesageid-' + result['firend_loginname']);
          var mes_num = parseInt(mes_li.find('.bg-green').text());
          $('#head_message_num').animate({
            backgroundColor: '#f0ad4e'
          }, 500);
          $('#head_message_num').html((parseInt($('#head_message_num').text() ) - mes_num) + '');
          $('#head_message_num').animate({
            backgroundColor: '#5cb85c'
          }, 500);
          $('#head_message_num2').html((parseInt($('#head_message_num2').text() ) - mes_num) + '');
          mes_li.remove();
        }
        //$("#message_box").scrollTop($("#message_box").height());
      }
    });
  };
  var add_contacts = $('#add-contacts').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  }, {
    name: 'in_firend',
    displayKey: 'name',
    source: in_firend.ttAdapter(),
    templates: {
      header: '<h3 class="league-name-firend">好友</h3>',
      empty: [
        '<div class="empty-message">',
        '无',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<p><img src="{{avatar_small}}" class="img-circle"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>')
    }
  }, {
    name: 'department_not_firend',
    displayKey: 'name',
    source: department_not_firend.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">本单位</h3>',
      empty: [
        '<div class="empty-message">',
        '无',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<p><img src="{{avatar_small}}" class="img-circle"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>')
    }
  }, {
    name: 'discipline_not_firend',
    displayKey: 'name',
    source: discipline_not_firend.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">同学科</h3>',
      empty: [
        '<div class="empty-message">',
        '无',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<p><img src="{{avatar_small}}" class="img-circle"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>')
    }
  }, {
    name: 'not_firend',
    displayKey: 'name',
    source: not_firend.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">全部陌生人</h3>',
      empty: [
        '<div class="empty-message">',
        '无',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<p><img src="{{avatar_small}}" class="img-circle"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>')
    }
  });
  add_contacts.on('typeahead:selected', function(evt, data) {
    if (data['isfirend'] == 'false') {
      add_contact(data.id);
    } else {
      $('#' + data['contact_id'] + ' a').trigger("click");
    }
  });
  //发送消息
  $('#add_message').click(function() {
    url = $(this).attr('add-url');
    message = $('#message_content').val();
    if (typeof url !== 'undefined' && message !== '') {
      $.ajax({
        url: url,
        type: 'PUT',
        data: {
          content: message
        },
        success: function(data) {
          if (data['status'] == 'true') {
            var time = new Date();
            var time_format= time.getHours() + ':' + time.getMinutes();
            var mes = Handlebars.compile('<div class="item"><img src="{{avatar}}" alt="user image" class="online"/><p class="message"><a href="{{userurl}}" class="name"><small class="text-muted pull-right"><i class="fa fa-clock-o"></i>{{time}}</small>{{name}}</a>{{content}}</p></div>');
            $(mes({
              avatar: data['avatar'],
              time: time_format,
              name: data['name'],
              userurl: '/'+$('#add_message').data('myloginname'),
              content: $('#message_content').val()
            })).appendTo('#message_box').hide().slideDown(300);
            $("#message_box").animate({
              scrollTop: $('#message_box')[0].scrollHeight
            }, 1000);
          } else {
            Messenger().post({
              message: data['message'],
              type: 'error',
              showCloseButton: true
            });
          }
          $('#message_content').val('');
        }
      });
    }
  });
});