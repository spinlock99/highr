// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//
// extend JQuery with submitWithAJAX
//
jQuery.fn.submitWithAjax = function () {
    this.submit(function() {
	    $.post($(this).attr('action'), $(this).serialize(), null, "script");
	    return false;
	});
};

// Make this available once the document is loaded
$(document).ready(function() {
	$("#user_edit").submitWithAjax();
    })
// jquery-ui tabs magic
$(function() {
	$("#team_tabs").tabs();
    });
