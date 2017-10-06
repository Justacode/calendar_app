$(document).ready(function() {
    $(".occurrences").on ("click", function() {
				if($("#event_occurrence_once").is(":checked")) {
	    			$(".finishes_at").slideUp();
				}	else {
	    			var element = $(".finishes_at");
	    			element.slideDown();
				}
    });
});