$(function() {
	$('.win-height').css('max-height', $(window).height() - 300);
	$('#add-group-member').attr("readonly",true);
	var member_item = Handlebars.compile('<tr><td><a href="{{userurl}}"><img src="{{avatar}}" class="img-circle"><span style="font-size: 18px;font-weight: bold;color: #3c8dbc">{{name}}</span></a></td><td><span class="badge bg-blue">{{department}}</span></td><td><div class="btn-group"><a class="btn btn-info dropdown-toggle {{disabled}}" data-toggle="dropdown">{{type}}<span class="fa fa-caret-down"></span></a><ul class="dropdown-menu"><li><a href="#">管理员</a></li><li><a href="#">组成员</a></li></ul></div></td><td><button type="button" class="btn btn-danger {{disabled}}"><span class="fa fa-times"></span>删除</button></td></tr>');
	var not_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		remote: $('#add-group-member').attr('not-firend-url') + '?q=%QUERY'
	});
	var department_not_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
	    //remote: '/users/index.json?q=%QUERY',
	    prefetch: $('#add-group-member').attr('department-not-firend-url')
	    //local: $.map(states, function(state) { return { value: state }; })
	});
	var discipline_not_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
	    //remote: '/users/index.json?q=%QUERY',
	    prefetch: $('#add-group-member').attr('discipline-not-firend-url')
	    //local: $.map(states, function(state) { return { value: state }; })
	});
	var in_firend = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
	    //remote: '/users/index.json?q=%QUERY',
	    prefetch: $('#add-group-member').attr('in-firend-url')
	    //local: $.map(states, function(state) { return { value: state }; })
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
						avatar: data['avatar'],
						type: data['type'],
						name: data['name'],
						userurl: '/'+data['loginname'],
						department: data['department'],
						disabled: (data['type'] == '建立者') ? 'disabled' : ''
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
		          $('#add-group-member').attr("readonly",true);
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
  	view_group = function(url, button_id) {
	    $.ajax({
	      url: url,
	      type: 'GET',
	      success: function(result) {
	        //$('#message_title').html('<i class="fa fa-comments-o"></i>与'+result['firend_username']+'的会话');
	        $('#group_members_table tbody tr').remove();
	        $('#groups-list').children().removeClass("active");
	        $('#my-groups-list').children().removeClass("active");
	        $('#' + button_id).addClass("active");
	        $('#add-group-member').attr("readonly",false);
	        $('#add-group-member').attr("add-member-url",'/admin/groups/'+button_id+'/add_member.json');
	        
	        $.each(result['members'], function(index, value) {
	          $('#group_members_table tbody').append(member_item({
	            avatar: value['avatar'],
	            type: value['type'],
	            name: value['name'],
	            userurl: '/'+value['loginname'],
	            department: value['department'],
	            disabled: (value['type'] == '建立者') ? 'disabled' : ''
	          }));
	        });
	      }
	    });
        return false;
    };
});