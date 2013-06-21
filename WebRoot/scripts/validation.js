$(function(){
	$('[required="required"]').focusout(function(){
		var text = $(this).val();
		var name = $(this).attr("name");
		
		if(text.length <= 0){
			$(this).addClass("input-validation-error");
			$('span[data-valmsg-for="' + name + '"]').attr("class", "field-validation-error");
			$('span[data-valmsg-for="' + name + '"]').html(name + " is required");
		}else{
			
			$(this).removeClass("input-validation-error");
			$('span[data-valmsg-for="' + name + '"]').attr("class", "field-validation-valid");
			$('span[data-valmsg-for="' + name + '"]').html("");		
		}
	});	
});

function validate(){
	var isGreen = true;
	$('[required="required"]').each(function(i, val){
		console.log( "i ->" + val);
		
		if(val.val() <= 0){
			green = false;
			var  name = obj.attr("name");
			obj.addClass("input-validation-error");
			$('span[data-valmsg-for="' + name + '"]').attr("class", "field-validation-error");
			$('span[data-valmsg-for="' + name + '"]').html(name + " is required");
		}
	});
	
	return isGreen;
}