$(document).ready(function() {

  var value = $(this).find("option:selected").attr("value");
    if (value != "once"){
      $(".finish-date-params").show();
    }

    $("#event_frequency").change(function(){
  		var value = $(this).find("option:selected").attr("value");

  		switch (value){
    		case "once":
    			$(".finish-date-params").slideUp();
      		break;
      	default:
      		$(".finish-date-params").slideDown();
      		break;		
  		}
		});

		  $(".event-form").on ("click", function() {
				if($("#forever").is(":checked")) {
	    			$(".finish_date").slideUp();
				}	else {
	    			$(".finish_date").slideDown();
				}
    });
});