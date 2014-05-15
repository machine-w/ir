$ ->
	$("#doc_container").infinitescroll
		navSelector: "nav.pagination"
		nextSelector: "nav.pagination a[rel=next]"
		itemSelector: "#doc_container div.doc_item"
	$("#masonry-container").infinitescroll
		navSelector: "nav.pagination"
		nextSelector: "nav.pagination a[rel=next]"
		itemSelector: "#masonry-container div.pitem"
		loading:
			msgText: "加载中..."
			finishedMsg: '没有新数据了...'
			selector: '.loading'
	,
		(newElems)->
			$newElems = $(newElems)
			$("#masonry-container").masonry "appended", $newElems