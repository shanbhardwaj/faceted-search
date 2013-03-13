$(document).ready(function(){
	$(".winedetailright").hide();
	$("#moredetail").click(function(){
		$("#moredetail").hide();
		$(".winedetailright").show();
	});
    $('.odd').live('mouseover', function() {
    	$(this).find('div:last').show();
    }).live('mouseout',function() {
			$(this).find('div:last').hide();
  	});
	$('.price').live('mouseover', function() {
		$(this).find('div:first').show();
  }).live('mouseout',function() {
 		$(this).find('div:first').hide();
  });
	$('.retailshow').live('mouseover', function() {
		$(this).find('div:first').show();
  }).live('mouseout',function() {
		$(this).find('div:first').hide();
  });

});
function clearText(field){
		if (field.defaultValue == field.value) field.value = '';
		else if (field.value == '') field.value = field.defaultValue;
		}
			
$(document).ready(function() {
$('a[rel=shareit], #shareit-box').click(function() {		
	var height = $(this).height();
	var top = $(this).offset().top;
	var left = $(this).offset().left + ($(this).width() + 1);
	var value = $(this).attr('href').split('|');
	var field = value[0];
	var url = encodeURIComponent(value[0]);
	var title = encodeURIComponent(value[1]);
	$('#shareit-header').height(height);
	$('#shareit-box').show();
	$('#shareit-box').css({'top':top, 'left':left});
	$('a.shareit-sm').attr('target','_blank');
	$('a[rel=shareit-mail]').attr('href', 'http://mailto:?subject=' + title);
	$('a[rel=shareit-delicious]').attr('href', 'http://del.icio.us/post?v=4&amp;noui&amp;jump=close&amp;url=' + url + '&title=' + title);
	$('a[rel=shareit-designfloat]').attr('href', 'http://www.designfloat.com/submit.php?url='  + url + '&amp;title=' + title);
	$('a[rel=shareit-digg]').attr('href', 'http://digg.com/submit?phase=2&amp;url=' + url + '&amp;title=' + title);
	$('a[rel=shareit-stumbleupon]').attr('href', 'http://www.stumbleupon.com/submit?url=' + url + '&title=' + title);
	$('a[rel=shareit-twitter]').attr('href', 'http://twitter.com/home?status=' + title + '%20-%20' + title);
});
$('.close').click(function () {
	$('#shareit-field').val('');
	$('#shareit-box').hide();
});
$('#shareit-field').click(function () {
	$(this).select();
});
});

var tArrow = true;
var tArrow1 = true;
var tArrow2 = true;


	$(".findnear").click(function() {
		if(tArrow){
			$('#arrow').attr('src', '/assets/ArrowDownRight.jpg');
			tArrow = false;
		}else{
			$('#arrow').attr('src', '/assets/ArrowDown.jpg');
			tArrow = true;
		}
  		$("#nearbyshowdiv").toggle()
	});
  $(".findonline").click(function() {
		if(tArrow1){
			$('#arrow1').attr('src', '/assets/ArrowDownRight.jpg');
			tArrow1 = false;
		}else{
			$('#arrow1').attr('src', '/assets/ArrowDown.jpg');
			tArrow1 = true;
		}
   $("#onlineshowdiv").toggle()
  });
  $(".findbar").click(function() {
		if(tArrow2){
			$('#arrow2').attr('src', '/assets/ArrowDownRight.jpg');
			tArrow2 = false;
		}else{
			$('#arrow2').attr('src', '/assets/ArrowDown.jpg');
			tArrow2 = true;
		}
   $("#barshowdiv").toggle()
  });
  
$("#addtolist").click(function() {
	$("#addwinediv").overlay({
		top: 150,
		mask: {
		color: '#E0E0E0',
		loadSpeed: 1000,
		opacity: 0.9
		},
		closeOnClick: false,
		api: true
		})
		var ol = $("#addtolistdiv").overlay({api: true});
		setTimeout(function() {
		ol.load();
		}, 1);
});
function togglespiner(showHideDiv) {
       var ele = document.getElementById(showHideDiv);
       if(ele.style.display == "block") {
              ele.style.display = "none";
       }
       else {
			if (showHideDiv == "wineindicator"){
				jQuery("#wineindicator").css("margin-top",window.pageYOffset); 
			}
            ele.style.display = "block";
       }
}
