$(function() {
	if ($("body").data('backpicture') == '' || $("body").data('backpicture') == [] ) 
	{
		$.backstretch("/images/back/default8.jpg");
        //$("body").addClass('defaultback');
    }
    else
    {
    	//alert($("body").data('backpicture').toString().split(','));
    	$.backstretch($("body").data('backpicture'),{duration: 10000, fade: 750});
    }
	
});
	