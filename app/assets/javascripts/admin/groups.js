$(function() {
	$('.win-height').css('max-height', $(window).height() - 300);
	$('#add-group-member').attr("disabled",true);
	$('#add-group-member').css("background-color", "white");

	var member_item = Handlebars.compile('<tr id="{{member_id}}"><td><a href="{{userurl}}"><img src="{{avatar}}" class="img-circle"><span style="font-size: 18px;font-weight: bold;color: #3c8dbc">{{name}}</span></a></td><td><span class="badge bg-blue">{{department}}</span></td><td><div class="btn-group"><a class="btn btn-info dropdown-toggle {{disabled}}" data-toggle="dropdown">{{type}}<span class="fa fa-caret-down"></span></a><ul class="dropdown-menu"><li><a href="" onclick="modify_group_member(\'{{member_id}}\',\'admin\');return false;">管理员</a></li><li><a href="" onclick="modify_group_member(\'{{member_id}}\',\'normal\');return false;">组成员</a></li></ul></div></td><td><a class="btn btn-danger {{disabled}}" onclick="delete_group_member(\'{{member_id}}\');return false;"><span class="fa fa-times"></span>删除</a></td></tr>');
	var mes = Handlebars.compile('<div class="item"><img src="{{avatar}}" alt="user image" class="online"/><p class="message"><a href="{{userurl}}" class="name"><small class="text-muted pull-right"><i class="fa fa-clock-o"></i>{{time}}</small>{{name}}</a>{{content}}</p></div>');
	var mes_with_doc = Handlebars.compile('<div class="item"><img src="{{avatar}}" alt="user image" class="online"/><p class="message"><a href="{{userurl}}" class="name"><small class="text-muted pull-right"><i class="fa fa-clock-o"></i>{{time}}</small>{{name}}</a>{{content}}</p><div class="attachment"><h4>{{add_document_title}}</h4><p class="filename">{{add_document_content}}</p><div class="pull-right"><a href="{{add_document_url}}" class="btn btn-primary btn-sm btn-flat">查看文档</a></div></div></div>');
	var not_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		remote: $('#add-group-member').attr('not-firend-url') + '?q=%QUERY'
	});
	var department_not_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		prefetch: $('#add-group-member').attr('department-not-firend-url')
	});
	var discipline_not_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		prefetch: $('#add-group-member').attr('discipline-not-firend-url')
	});
	var in_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		prefetch: $('#add-group-member').attr('in-firend-url')
	});
	not_firend.initialize();
	department_not_firend.initialize();
	discipline_not_firend.initialize();
	in_firend.initialize();
	var add_group_members = $('#add-group-member').typeahead({
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
add_group_members.on('typeahead:selected', function(evt, data) {
	$.post(
		$('#add-group-member').attr("add-member-url"), 
		{add_id: data.id},
		function(data) {
			if (data['status'] == 'true') {
				$(member_item({
					member_id: data['memberid'],
					avatar: data['avatar'],
					type: data['type'],
					name: data['name'],
					userurl: '/'+data['loginname'],
					department: data['department'],
					disabled: data['disabled']
				})).prependTo('#group_members_table').hide().slideDown(300);
				Messenger().post({
					message: data['message'],
					type: 'success',
					showCloseButton: true
				});
			} else {
				Messenger().post({
					message: data['message'],
					type: 'error',
					showCloseButton: true
				});
			}
		}
	);
});

delete_group = function(url) {
	var result = confirm("确定删除吗？");
	if (result == true){
		$.ajax({
			url: url,
			type: 'DELETE',
			success: function(result) {
				if (result['status'] == 'true') {
					$('#' + result['group_id']).slideUp(300, function() {
						$('#' + result['group_id']).remove();

					});
					$('#groups-list').children().removeClass("active");
					$('#my-groups-list').children().removeClass("active");
					$('#group_members_table tbody tr').remove();
					$('#add-group-member').attr("disabled",true);
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
	}
	return false;
};

sign_out_group = function(url) {
	var result = confirm("确定退出吗？");
	if (result == true){
		$.ajax({
			url: url,
			type: 'POST',
			success: function(result) {
				if (result['status'] == 'true') {
					$('#j_' + result['group_id']).slideUp(300, function() {
						$('#j_' + result['group_id']).remove();
					});
					$('#groups-list').children().removeClass("active");
					$('#my-groups-list').children().removeClass("active");
					$('#group_members_table tbody tr').remove();
					$('#add-group-member').attr("disabled",true);
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
	}
	return false;
};

delete_group_member = function(member_id) {
	var result = confirm("确定删除吗？");
	if (result == true){
		$.post(
		$('#add-group-member').attr("delete-member-url"), 
		{memberid: member_id},
		function(data) {
			if (data['status'] == 'true') {
				$('#group_members_table').find('#'+member_id).slideUp(300);
				Messenger().post({
					message: data['message'],
					type: 'success',
					showCloseButton: true
				});
			} else {
				Messenger().post({
					message: data['message'],
					type: 'error',
					showCloseButton: true
				});
			}
		}
	);
	}
	return false;
};

modify_group_member = function(member_id,type) {
		$.post(
		$('#add-group-member').attr("modify-member-url"), 
		{memberid: member_id,type: type},
		function(data) {
			if (data['status'] == 'true') {
				$('#group_members_table').find('#'+member_id).find('.dropdown-toggle').html(data['type_name']+'<span class="fa fa-caret-down"></span>');
				Messenger().post({
					message: data['message'],
					type: 'success',
					showCloseButton: true
				});
			} else {
				Messenger().post({
					message: data['message'],
					type: 'error',
					showCloseButton: true
				});
			}
		}
	);
	return false;
};

view_group = function(url, button_id) {
	$.ajax({
		url: url,
		type: 'GET',
		success: function(result) {
            //$('#message_title').html('<i class="fa fa-comments-o"></i>与'+result['firend_username']+'的会话');
            $('#group_members_table tbody tr').remove();
            $('#message_box').empty();
            $('#groups-list').children().removeClass("active");
            $('#my-groups-list').children().removeClass("active");
            $('#' + button_id).addClass("active");
            $('#j_' + button_id).addClass("active");
            if(result['enable_edit_member'] == 'true'){
                $('#add-group-member').attr("disabled",false);
            }else
            {
                $('#add-group-member').attr("disabled",true);
            }
            $('#add-group-member').attr("add-member-url",'/admin/groups/'+button_id+'/add_member.json');
            $('#add-group-member').attr("delete-member-url",'/admin/groups/'+button_id+'/del_member.json');
            $('#add-group-member').attr("modify-member-url",'/admin/groups/'+button_id+'/modify_member.json');

            $('#add_group_message').attr("add-message-url",'/admin/groups/'+button_id+'/add_message.json');
            $('#add_group_message').attr("data-group-id",button_id);

            $.each(result['members'], function(index, value) {
				$('#group_members_table tbody').append(member_item({
					member_id: value['memberid'],
					avatar: value['avatar'],
					type: value['type'],
					name: value['name'],
					userurl: '/'+value['loginname'],
					department: value['department'],
					disabled: result['enable_edit_member'] == 'true' ? value['disabled'] : 'disabled'
				}));
            });
            $.each(result['messages'], function(index, value) {
              if(value['add_document_title'] == '') {
                  $('#message_box').append(mes({
                    avatar: value['avatar'],
                    time: value['time'],
                    name: value['name'],
                    userurl: '/'+value['loginname'],
                    content: value['content']
                  }));
              }
              else
              {
                $('#message_box').append(mes_with_doc({
                  avatar: value['avatar'],
                  time: value['time'],
                  name: value['name'],
                  userurl: '/'+value['loginname'],
                  content: value['content'],
                  add_document_title: value['add_document_title'],
                  add_document_content: value['add_document_content'],
                  add_document_url: value['add_document_url']
                }));
              }
            });
            $("#message_box").animate({
              scrollTop: $('#message_box')[0].scrollHeight
            }, 1000);
            //清理消息按钮
           if ($('#ul_head_group_message').children('#groupmessageid-'+button_id).length !== 0) {
             var mes_li = $('#ul_head_group_message').children('#groupmessageid-' + button_id);
             var mes_num = parseInt(mes_li.find('.bg-green').text());
             $('#head_group_message_num').animate({
               backgroundColor: '#f0ad4e'
             }, 500);
             $('#head_group_message_num').html((parseInt($('#head_group_message_num').text() ) - mes_num) + '');
             $('#head_group_message_num').animate({
               backgroundColor: '#5bc0de'
             }, 500);
             $('#head_group_message_num2').html((parseInt($('#head_group_message_num2').text() ) - mes_num) + '');
             mes_li.remove();
           }
        }
	});
	return false;
};
//发送消息
$('#add_group_message').click(function() {
  url = $(this).attr('add-message-url');
  message = $('#message_content').val();
  if (typeof url !== 'undefined' && message !== '') {
    $.ajax({
      url: url,
      type: 'POST',
      data: {
        content: message
      },
      success: function(data) {
        if (data['status'] == 'true') {
          var time = new Date();
          var time_format= time.getHours() + ':' + time.getMinutes();
          $(mes({
            avatar: $('#add_group_message').attr('data-myavatar'),
            time: time_format,
            name: $('#add_group_message').data('myname'),
            userurl: '/'+$('#add_group_message').data('myloginname'),
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
$('#j_' + $('#groups-list').attr('data-ref-group') + ' a').trigger("click");
});