$ ->
	selMemberTemplate = (avatar,name,id) ->
		html =
			"""
			<a id="#{id}" class="sel_permission_select_member_del"><img src="#{avatar}" data-toggle="tooltip" title="#{name}" class="img-circle"><i class="fa fa-times"></i></a>
			"""
		$(html)
	hide_options =  ->
		$("#sel_permission_config_pane").hide();
		$("#sel_permission_public_pane").hide();
		$("#sel_permission_scope_pane").hide();
		$("#sel_permission_sel_department_pane").hide();
		$("#sel_permission_sel_discipline_pane").hide();
		$("#sel_permission_sel_mygroup_pane").hide();
		$("#sel_permission_sel_joingroup_pane").hide();
		$("#sel_permission_sel_contact_pane").hide();
		$("#sel_permission_sel_member_pane").hide();
	hide_options();
	$('#sel_permission_inherit').on "switch-change", (e, data) ->
        $('#sel_permission_config_pane').slideToggle()
    $('#sel_permission_private').on "switch-change", (e, data) ->
        $('#sel_permission_public_pane').slideToggle()
    $("#sel_permission_public_type").on "change", (e) ->
    	if e.val == 'scope'
    		$("#sel_permission_scope_pane").slideDown();
    	else
    		$("#sel_permission_scope_pane").slideUp();
    $("#sel_permission_public_scope").on "change", (e) ->
    	if e.added
	    	switch e.added.id
	    		when 'sel_department' then $("#sel_permission_sel_department_pane").slideDown();
	    		when 'sel_discipline' then $("#sel_permission_sel_discipline_pane").slideDown();
	    		when 'my_group' then $("#sel_permission_sel_mygroup_pane").slideDown();
	    		when 'join_group' then $("#sel_permission_sel_joingroup_pane").slideDown();
	    		when 'sel_contact' then $("#sel_permission_sel_contact_pane").slideDown();
	    		when 'user_list' then $("#sel_permission_sel_member_pane").slideDown();
    	if e.removed
    		switch e.removed.id
	    		when 'sel_department' then $("#sel_permission_sel_department_pane").slideUp();
	    		when 'sel_discipline' then $("#sel_permission_sel_discipline_pane").slideUp();
	    		when 'my_group' then $("#sel_permission_sel_mygroup_pane").slideUp();
	    		when 'join_group' then $("#sel_permission_sel_joingroup_pane").slideUp();
	    		when 'sel_contact' then $("#sel_permission_sel_contact_pane").slideUp();
	    		when 'user_list' then $("#sel_permission_sel_member_pane").slideUp();

	not_firend = new Bloodhound(
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
		queryTokenizer: Bloodhound.tokenizers.whitespace
		remote: $("#sel_permission_select_member").attr("not-firend-url") + "?q=%QUERY"
	)
	department_not_firend = new Bloodhound(
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
		queryTokenizer: Bloodhound.tokenizers.whitespace
		prefetch: $("#sel_permission_select_member").attr("department-not-firend-url")
	)
	discipline_not_firend = new Bloodhound(
	  	datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
	  	queryTokenizer: Bloodhound.tokenizers.whitespace
	  	prefetch: $("#sel_permission_select_member").attr("discipline-not-firend-url")
	)
	in_firend = new Bloodhound(
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace("query")
		queryTokenizer: Bloodhound.tokenizers.whitespace
		prefetch: $("#sel_permission_select_member").attr("in-firend-url")
	)
	not_firend.initialize()
	department_not_firend.initialize()
	discipline_not_firend.initialize()
	in_firend.initialize()

	typehead_select_member = $("#sel_permission_select_member").typeahead(
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
		jsono= JSON.parse $("#sel_permission_select_member_val").val()
		jsono.push data.id
		#$("#sel_permission_select_member_val").val($("#sel_permission_select_member_val").val()+","+data.id)
		$("#sel_permission_select_member_val").val JSON.stringify(jsono)
		$(selMemberTemplate(data.avatar_small,data.name,data.id)).prependTo('#sel_permission_sel_member_container').hide().slideDown(300);
		$("[data-toggle='tooltip']").tooltip();
		$(".sel_permission_select_member_del").click ->
			#val = $("#sel_permission_select_member_val").val()
			#re = new RegExp(",#{$(this).attr('id')}", "g");
			#$("#sel_permission_select_member_val").val(val.replace re, "")
			vals= JSON.parse $("#sel_permission_select_member_val").val()
			#alert "#{$(this).attr('id')}"
			unless vals.indexOf("#{$(this).attr('id')}") == -1
				vals.splice vals.indexOf("#{$(this).attr('id')}"), 1
			$("#sel_permission_select_member_val").val JSON.stringify(vals)
			$(this).slideUp(300).remove();
			return false
    			
