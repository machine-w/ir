$ ->
	$('#home_visit_department').select2();
	$('#home_visit_discipline').select2();
	# $('#home_visit_group').select2();
	$("#home_visit_department").on "change", (e) ->
		if e.added
			window.location.href = '/department/'+e.added.id
	$("#home_visit_discipline").on "change", (e) ->
		if e.added
			window.location.href = '/discipline/'+e.added.id
	# $("#home_visit_group").on "change", (e) ->
	# 	if e.added
	# 		window.location.href = '/group/'+e.added.id