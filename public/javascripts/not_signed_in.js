// initial text in email field on landing page form
$(document).ready(function(){
	var initialText = "your@email.com";
        $('#email').focus(function(){
		if( $(this).val()==initialText){
		    $(this).val("").removeClass("initial");
		}
	    });
	$('#email').blur(function(){
		if($(this).val()==""){
		    $(this).val(initialText).addClass("initial");
		}
	    });
    });
