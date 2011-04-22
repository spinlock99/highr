
	//Cufon Font replacement for h2 Headings
	Cufon.replace('h2,legend'); 

	$(document).ready(function() {
	
		//Nivo Slider
		$('#slider').nivoSlider({
			effect:'fade',
			animSpeed:500, 
			pauseTime:3000,
			controlNav:false
		});

		//Ajax Contact Form Submission
		$("#ajax-contact-form").submit(function(){
		var str = $(this).serialize();
		   $.ajax({
		   type: "POST",
		   url: "contact/contact.php",
		   data: str,
		   success: function(msg){ 
			$("#c-note").ajaxComplete(function(event, request, settings){
			if(msg == 'OK') // Message Sent? Show the 'Thank You' message and hide the form
			{
			result = '<div class="notification_ok">Your message has been sent. Thank you!</div>';
			$("#fields").hide();
			}
			else
			{
			result = msg;
			}
			$(this).html(result);
			});
			}
		 });
		return false;
		});
			
		//About FancyBox & NewsLetter Fancybox
		$("a#nl-inline,a#about-inline").fancybox({
			'transitionIn'		:'elastic',
			'overlayShow'		:false,
			'speedIn'			:600,
			'padding'			:0,
			'titleShow':false
		});
		
		//ContactForm FancyBox
		$("a#c-inline").fancybox({
			'transitionIn'		:'elastic',
			'overlayShow'		:false,
			'speedIn'			:600,
			'titleShow':false
		});
		
		//Screenshots FancyBox
		$("a[rel=s-thumbs]").fancybox({
			'transitionIn'	:	'elastic',
			'transitionOut'	:	'elastic',
			'titlePosition' 	: 'over',
			'speedIn'		:	600, 
			'speedOut'		:	200, 
			'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
				return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
			}
		});

		//Screenshots Fade Effect on hover
		$(function() {
			$(".s-thumbs").css("opacity","0.6");
			$(".s-thumbs").hover(function () {
			$(this).stop().animate({
			opacity: 1.0
			}, "medium");
			},
			function () {
			$(this).stop().animate({
			opacity: 0.6
			}, "medium");
			});
		});
		
		//notify to turnon js
		window.onload = function () {
			document.getElementById("no-script").style.display = "none";
		}
	
	});