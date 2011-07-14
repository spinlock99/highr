//
// initial text in email field on landing page form
//
$(document).ready(function(){
	var initialText = "friends@email.com";
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
//
// facebook recommend button
//
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
//
// twitter button
//
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
