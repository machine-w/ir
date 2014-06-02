$ ->
	$('#shared-folder-list').css('max-height', $(window).height() - 300)
	$('#my-folder-list').css('max-height', $(window).height() - 300)
	selFoderTemplate = (icon,name,id) ->
		html =
			"""
			<li id="#{id}"><a href="" onclick="$('#my-folder-list').children().removeClass('active'); $('#shared-folder-list').children().removeClass('active'); $(this).parent().addClass('active'); return false;"><i class="fa #{icon}"></i>#{name}</a></li>'
			"""
		$(html)
	not_firend = new Bloodhound(
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
		queryTokenizer: Bloodhound.tokenizers.whitespace
		remote: $("#sel-parent-folder-user").attr("not-firend-url") + "?q=%QUERY"
	)
	department_not_firend = new Bloodhound(
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
		queryTokenizer: Bloodhound.tokenizers.whitespace
		prefetch: $("#sel-parent-folder-user").attr("department-not-firend-url")
	)
	discipline_not_firend = new Bloodhound(
	  	datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
	  	queryTokenizer: Bloodhound.tokenizers.whitespace
	  	prefetch: $("#sel-parent-folder-user").attr("discipline-not-firend-url")
	)
	in_firend = new Bloodhound(
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
		queryTokenizer: Bloodhound.tokenizers.whitespace
		prefetch: $("#sel-parent-folder-user").attr("in-firend-url")
	)
	not_firend.initialize()
	department_not_firend.initialize()
	discipline_not_firend.initialize()
	in_firend.initialize()

	typehead_select_member = $("#sel-parent-folder-user").typeahead(
	  hint: true
	  highlight: true
	  minLength: 1
	,
	  name: "in_firend"
	  displayKey: "name"
	  source: in_firend.ttAdapter()
	  templates:
	    header: "<h3 class=\"league-name-firend\">好友</h3>"
	    empty: [
	      "<div class=\"empty-message\">"
	      "无"
	      "</div>"
	    ].join("\n")
	    suggestion: Handlebars.compile("<p><img src=\"{{avatar_small}}\" class=\"img-circle\"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>")
	,
	  name: "department_not_firend"
	  displayKey: "name"
	  source: department_not_firend.ttAdapter()
	  templates:
	    header: "<h3 class=\"league-name\">本单位</h3>"
	    empty: [
	      "<div class=\"empty-message\">"
	      "无"
	      "</div>"
	    ].join("\n")
	    suggestion: Handlebars.compile("<p><img src=\"{{avatar_small}}\" class=\"img-circle\"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>")
	,
	  name: "discipline_not_firend"
	  displayKey: "name"
	  source: discipline_not_firend.ttAdapter()
	  templates:
	    header: "<h3 class=\"league-name\">同学科</h3>"
	    empty: [
	      "<div class=\"empty-message\">"
	      "无"
	      "</div>"
	    ].join("\n")
	    suggestion: Handlebars.compile("<p><img src=\"{{avatar_small}}\" class=\"img-circle\"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>")
	,
	  name: "not_firend"
	  displayKey: "name"
	  source: not_firend.ttAdapter()
	  templates:
	    header: "<h3 class=\"league-name\">全部陌生人</h3>"
	    empty: [
	      "<div class=\"empty-message\">"
	      "无"
	      "</div>"
	    ].join("\n")
	    suggestion: Handlebars.compile("<p><img src=\"{{avatar_small}}\" class=\"img-circle\"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>")
	);
	typehead_select_member.on "typeahead:selected", (evt, data) ->
		$.get "/#{data.login_name}/folders/shared.json", (result) ->
			$('#shared-folder-list').empty();
			$.each result, (index, value) ->
				$(selFoderTemplate(value.folder_type.image_path,value.name,value._id.$oid)).prependTo('#shared-folder-list').hide().slideDown(300);

	$.get $('#my-folder-list').data('myfoldersurl'), (result) ->
			$.each result, (index, value) ->
				$(selFoderTemplate(value.folder_type.image_path,value.name,value._id.$oid)).prependTo('#my-folder-list').hide().slideDown(300);

