$(function() {
	if ($("body").data('backpicture') == '' || $("body").data('backpicture') == [] ) 
	{
		$.backstretch("/images/back/default.jpg");
        //$("body").addClass('defaultback');
    }
    else
    {
    	//alert($("body").data('backpicture').toString().split(','));
    	$.backstretch($("body").data('backpicture'),{duration: 50000, fade: 750});
    }
	
});
	