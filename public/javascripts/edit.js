$(function() {
	//
	// show half opened curtains when the user comes to edit invitation
	//
	$('#container').before('<div class="curtain" id="left"></div>' +
                               '<div class="back-drop" id="center-left"></div>' +
                               '<div class="back-drop" id="center-right"></div>' +
                               '<div class="curtain" id="right"></div>');
        $('.curtain').css('float', 'left').css('width','25%').css('height','915px');
        $('.back-drop').css('float', 'left').css('width','25%').css('height','915px');
        $('#right').css('background-position','-100px','0px');
    });