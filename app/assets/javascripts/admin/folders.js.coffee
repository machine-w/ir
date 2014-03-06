# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$('.select2').select2();
	#alert(JSON.parse($("#add_folder_group_data").val()))
	$("#add_folder_group").select2
		createSearchChoice: (term, data) ->
			if $(data).filter( -> this.text.localeCompare(term) == 0 ).length == 0
				{id:term, text:term}
		multiple: false,
		data: ->
			result = JSON.parse $("#add_folder_group_data").val()
			li = []
			for item in result
				li.push({id: item['_id']['$oid'],text: item['name'] })
			return { text:'text', results: li }


