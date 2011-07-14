// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).click(function() {
	//	$("#left").hide("slide", { direction: "left" }, 1000,  function() {
	//	$("#left").replaceWith('<div class="back-drop"></div>')
	//	    });
	//	$("#right").hide("slide", {direction: "right" }, 1000, function() {
	//	$("#right").replaceWith('<div class="back-drop"></div>')
	//  });
	//	$("#right").replaceWith('<div class="back-drop"></div>')
	//$("#right").animate({ width: 25%}, 1000);
	$("#content").animate({ opacity: '1.0' }, 1000);
	$("#left").animate({ width: '25%' }, 1000);
	$("#center-left").animate({ width: '25%' }, 1000);
	$("#center-right").animate({ width: '25%' }, 1000);
	$("#right").animate({ width: '25%' }, 1000);
	
    });
// Make this available once the document is loaded
$(document).ready(function() {
	$("#add_team_mate").click(function() {
		alert("Hello world!");
		$("#team_action").html("sucka");
		return false;
	    });
    });
// jquery-ui tabs magic
$(function() {
	$("#team_tabs").tabs();
    });
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
// facebook recommend button
$(function() {
	likebutton = 
	    '<fb:like href="" send="" width="100" show_faces="" ' +
	    'font="" layout="button_count" action="recommend">' +
	    '</fb:like>';
	$.getScript('http://connect.facebook.net/en_US/all.js', function() {
		FB.init({appId: 141936272547391, 
			    status: true, 
			    cookie: true, 
			    xfbml: true
			    });
		$('#facebook').replaceWith(likebutton);
	    });
    });
// twitter button
$(function() {
	tweetbutton = 
	    '<a href="http://twitter.com/share" class="twitter-share-button"' +
	    ' data-text="Atomic Broadcast is the next big thing!"' +
	    ' data-count="horizontal">Tweet</a>';
	
	$('#twitter').replaceWith(tweetbutton);
	$.getScript('http://platform.twitter.com/widgets.js', function(){
		return true;
	    });
    });




/*
        $('#submit').hover(function(){ 
		// Change the input image's source when we "roll on"
		$(this).attr({ src : '/images/Submit-Button_Hover.png'});
	    },
	    function(){ 
		// Change the input image's source back to the default 
		// on "roll off"
		$(this).attr({ src : '/images/Submit-Button.png'});
	    });
	*/
   

/*	
	if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                if (cookie.substring(0, 11) == 'user_email=') {
                    cookieValue = decodeURIComponent(cookie.substring(11));
                    postData(cookieValue);
		    break;
                }
            }
        }
    });
function postData(emailVal) {
    $.post('postemail.php', {email: emailVal, referralid: $("#refid").val()},
	   function(data){
	       $("#shareurl").val(data.reflink).show();
	       
	       $("#facebook").html('<iframe src="http://www.facebook.com/plugins/like.php?href=' + escape(data.reflink) + '&amp;layout=standard&amp;show_faces=false&amp;width=100&amp;action=recommend&amp;font=lucida+grande&amp;colorscheme=light&amp;height=25" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:25px;" allowTransparency="true"></iframe>').show();
	       
	       
	       $("#emailbox").slideUp();
	       $("#pagesubmit").slideDown();
	       if (data.newuser) {
		   $("#header_text").html('Thanks! Want to get an early invitation?');
		   $("#paragraph_text").html('Invite at least 3 friends using the link below. The more friends you invite, the sooner you&#146;ll get access!');
	       } else {
		   $("#header_text").html('Welcome back!');
		   $("#paragraph_text").html('<b>Your live stats: ' + data.clicks + ' clicks, ' + data.signups + ' sign ups</b><br /><br />The more friends you invite, the sooner you&#146;ll get access!');
	       }
	       var d = new Date();
	       d.setFullYear(d.getFullYear() + 1);
	       document.cookie = 'user_email=' + escape(data.email) + '; expires=' + d.toUTCString() + '
; path=/; domain=.launchrock.com;';
	   }, "json");
}
$('form').submit(function(){
	
	$(".error").hide();
        var hasError = false;
        var emailReg = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	
        var emailaddressVal = $("#email").val();
        if(emailaddressVal == '') {
            $("#information").after('<span class="error">Please enter your email address.</span>');
            hasError = true;
        }
	
        else if(!emailReg.test(emailaddressVal) || emailaddressVal == 'your@email.com') {
            $("#information").after('<span class="error">Enter a valid email address.</span>');
            hasError = true;
        }
	
        if (!hasError) {
	    postData($('#email').val());
	}
	return false;
    });
	*/