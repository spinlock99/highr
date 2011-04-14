// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Make this available once the document is loaded
$(document).ready(function() {
	$("#add_team_mate").click(function() {
		alert("Hello world!");
		$("#team_action").html("sucka");
		return false;
	    });
    });

$(function() {
	$("#team_tabs").tabs();
    });