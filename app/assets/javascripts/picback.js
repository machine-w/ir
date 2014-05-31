$(function() {
	if ($("body").data('backpicture') == '' || $("body").data('backpicture') == [] ) 
	{
		$.backstretch("/images/back/back.jpg");
    }
    else
    {
    	//alert($("body").data('backpicture').toString().split(','));
    	$.backstretch($("body").data('backpicture'),{duration: 10000, fade: 750});
    }
	
});
	