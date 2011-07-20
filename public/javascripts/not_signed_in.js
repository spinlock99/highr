// initial text in email field on landing page form
$(document).ready(function(){
	//
	// Show closed curtains to non-signed in users
	//
	$('#content').css('opacity', '0.8')
	$('#container').before('<div class="curtain" id="left"></div>' +
			       '<div class="back-drop" id="center-left"></div>' +
			       '<div class="back-drop" id="center-right"></div>' +
			       '<div class="curtain" id="right"></div>');
	$('.curtain').css('float', 'left').css('width','50%').css('height','915px');
	$('.back-drop').css('float', 'left').css('width','0%').css('height','915px');
	$('#right').css('background-position','-100px','0px');
	//
	// setup example email address
	//
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
	//
	// AJAX call to submit user_new form
	//
	$("#user_new").submitWithAjax();
    });
