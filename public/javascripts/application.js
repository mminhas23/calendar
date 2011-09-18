$(function()
{
	$('.date-pick').datePicker()
	$('#course_start_date').bind(
		'dpClosed',
		function(e, selectedDates)
		{
			var d = selectedDates[0];
			if (d) {
				d = new Date(d);
				$('#course_end_date').dpSetStartDate(d.addDays(1).asString());
			}
		}
	);
	$('course_end_date').bind(
		'dpClosed',
		function(e, selectedDates)
		{
			var d = selectedDates[0];
			if (d) {
				d = new Date(d);
				$('#course_start_date').dpSetEndDate(d.addDays(-1).asString());
			}
		}
	);



    $('#course-categories input').live('click', function(){
        var element = $(this);
        var courseId = $(this).val();
        if(element.attr('checked')=='checked'){
            jQuery.get("/students/courses/"+courseId);
            $('#batches-available').css('display','block');
        }else{
           $('#batches-available').html("");
            $('#batches-available').css('display','none');
        }


//    ,function(data){
//            console.log(data);
//            console.log("...");
//            $("#batches_available").html(data);
//        });

//        if($(this).attr('checked')=='checked'){
//            $('#batches-available').html("<%= @user.email %>");
//            $('#batches-available').html("<%= escape_javascript(@user.email) %>");
//
//            console.log("you checked");
//        }else{
//            console.log('you unchecked');
//        }
//        $('#batches-available').toggleClass('hidden');
    });

    $('#batches-available input').live('click',function(){
        alert("Hello");
    });

});


