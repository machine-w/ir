$(function() {
	$('.win-height').css('max-height', $(window).height() - 300);
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
  	};
});