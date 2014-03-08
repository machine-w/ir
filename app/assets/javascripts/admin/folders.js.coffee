# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("#add_folder_group").select2
		createSearchChoice: (term, data) ->
			if $(data).filter( -> this.text.localeCompare(term) is 0 ).length is 0
				{id:term, text:term}
		multiple: false,
		data: ->
			result = JSON.parse $("#add_folder_group_data").val()
			li = []
			for item in result
				li.push({id: item['_id']['$oid'],text: item['name'] })
			return { text:'text', results: li }

	$("#add_folder_submit").click  (event) ->
  		if $(this).parent().parent().parent().valid() is false
    		#$("#error-text").text "填写信息不完整。"
    		false
	


