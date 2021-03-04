
/* In milliseconds */
var fadeIn = 200;
var fadeOut = 2000;

$(function(){
	window.onload = (e) => {
		$("#text").hide();
		$("#_description").hide();
		window.addEventListener('message', (event) => {
			var item = event.data;

			if (item !== undefined && item.type === "ui") {
                /* if the display is true, it will show */
				if (item.display === true) {
					var zones = item.zone
					var description = item.description
					$("#container").append('<img class="imgA1" id = "' + item.zone +'" src="/html/img/' + item.zone + '.png">')
					$("#" + item.zone).hide();
					$("#_description").html(description.toUpperCase());
					$("#text").html(zones.toUpperCase())
					$("#text").fadeIn(fadeIn);
					$("#_description").fadeIn(fadeIn);
                    $("#" + item.zone).fadeIn(fadeIn);
				}else{
					$("#text").fadeOut(fadeOut);
					$("#_description").fadeOut(fadeOut);
					$.when($("#" + item.zone).fadeOut(fadeOut)).done(function() {
						$("#" + item.zone).remove()
					});
				}		
			}
		});
	};
});




