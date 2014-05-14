$ ->
	$("#doc_container").infinitescroll
		navSelector: "nav.pagination"
		nextSelector: "nav.pagination a[rel=next]"
		itemSelector: "#doc_container div.doc_item"