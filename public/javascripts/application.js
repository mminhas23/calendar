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

    var categoryIds = new Array();
    $('#course-categories :checked').each(function(index){
        categoryIds[index] =  $(this).val();
    });

    $('#course-categories input').live('click', function(){
        var element = $(this);
        var categoryId = $(this).val();
        if(element.attr('checked')=='checked'){
            jQuery.get("/students/courses/"+categoryId);
        }else{
           $('#courses-available').html("");
        }
    });

    $('#courses-available input').live('click',function(){
        var element = $(this);
        var courseId = $(this).val();
        if(element.attr('checked')=='checked'){
            jQuery.get("/students/batches/"+courseId);
        }else{
           $('#batches-available').html("");
        }
    });

    $('#student_student_type').change(function(){
        type = $(this).val();
        if(type =='Type_3'){
            $('.type3Details').css('display','block');
        }else{
            resetType3Details();
        }
    });

});

function resetType3Details() {
    $('.type3Details input').each(function(){
        $(this).val("");
    });
    $('.type3Details').css('display','none');
}

function removeType3Details() {

}


function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".comment-fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().after(content.replace(regexp, new_id));
}