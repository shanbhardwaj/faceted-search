//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
function remove_field(element, item) {
  element.up(item).remove();
}
function hideModal(modal_id){
	$("#"+modal_id).modal('hide');
	return false;
}
function imagePreview(f, form_id, img_prev_id, item){
	  jQuery('#spinneruploadimg').show();
      var f = jQuery('#' + form_id);
      var tAction = f.attr('action');
      f.attr('target', 'if_img');
      f.attr('action', '/user/image_preview?img_prev_id=' + img_prev_id + '&itemimg=' + item);
      f.submit();
      f.removeAttr('target');
      f.attr('action', tAction);
      jQuery('#ind_' + img_prev_id).show();
}
function imagePreviewRtl(f, form_id, img_prev_id, item){
	  jQuery('#spinneruploadimg').show();
      var f = jQuery('#' + form_id);
      var tAction = f.attr('action');
      f.attr('target', 'if_img');
      f.attr('action', '/user/image_preview_rtl?img_prev_id=' + img_prev_id + '&itemimg=' + item);
      f.submit();
      f.removeAttr('target');
      f.attr('action', tAction);
      jQuery('#ind_' + img_prev_id).show();
}
  

$(function() {
	$('#sapendingpage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});
$(function() {
	$('#mylistwinepage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});

$(function() {
	$('#findwinepage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});

$(function() {
	$('#storesdatalistdiv th a,#storesdatalistdiv .store-pagination a').live('click', function() {
		$.getScript(this.href);
		return false;
     });
});

$(function() {
	$('#restdatalistdiv th a,#restdatalistdiv .rest-pagination a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});

$(function() {
	$('#searchwine th a,#admin-pagination #retailersearchpage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
	$("#retailerWineSearchForm input").keyup(function() {
		if(timer){
			clearTimeout(timer);
		}
		timer = setTimeout(searchWineToAdd,300);
	});
});

function searchWineToAdd(){
	if(searchWineAjaxRunning && searchWineAjaxRequest != ''){
		searchWineAjaxRequest.abort();
		searchWineAjaxRunning = false;
	}
	searchWineAjaxRequest = $.ajax({
		url: $("#retailerWineSearchForm").attr("action"),
		data: $("#retailerWineSearchForm").serialize(),
		dataType: "script",
		beforeSend: function(){
			searchWineAjaxRunning = true;
			$('#showsearchwineprocessing').show();
			jQuery("#leftloder").css("margin-top",(window.pageYOffset)+50); 
			$('#showsearchwineprocessing').fadeTo("slow", 0.83);
		},
		complete: function(){searchWineAjaxRunning = false;$('#showsearchwineprocessing').hide();}
	});
	// searchWineAjaxRequest = $.get($("#retailerWineSearchForm").attr("action"), $("#retailerWineSearchForm").serialize(), null, "script");
	return false;	
}

$(function() {
	$('#userlist th a,#admin-pagination #userpage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
	$("#UserSearchForm input").keyup(function() {
    $.get($("#UserSearchForm").attr("action"), $("#UserSearchForm").serialize(), null, "script");
    return false;
  });
});
$(function() {
	$('#retailer-winetab th a, #winepage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});
$(function() {
	$('#retailerlist th a,#admin-pagination #retailerpage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
	$("#RetailerSearchForm input").keyup(function() {
    $.get($("#RetailerSearchForm").attr("action"), $("#RetailerSearchForm").serialize(), null, "script");
    return false;
  });
});
$(function() {
	$('#admin-pagination #winepage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
	$("#WineSearchForm input").keyup(function() {
    $.get($("#WineSearchForm").attr("action"), $("#WineSearchForm").serialize(), null, "script");
    return false;
  });
});
$(function() {
	$('#admin-pagination #retailerwinepage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});
$(function() {
	$('#admin-pagination #retailersearchpage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});
$(function() {
	$('#admin-pagination #waretailerpage a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});


$(function() {
  $('#sortaccount th a, #sortaccount #togg a').live('click', function() {
  $('#spinner').overlay({
    top: 250,
    closeOnClick: true,
    api: true
    })
    var ol = $("#spinner").overlay({api: true});
    setTimeout(function() {
    ol.load();
    }, 1);
    $.getScript(this.href);
    return false;
  });
});

$(function() {
        $('#app_install th a,#app_install #toggleText a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#phone_calls th a,#phone_calls #togglText a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#sms th a,#sms #toggText a').live('click', function() {
        //$('#sms th#aa a').html('<img src="/assets/ajax-loader.gif" />');
        $('#spinner').overlay({
                top: 300,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
        //        $(this).overlay().close();
                return false;
        });
});
$(function() {
        $('#mms th a,#mms #toggl1 a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#gps th a,#gps #toggl2 a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#accelerometer th a,#accelerometer #toggl6 a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#appdatauses th a,#appdatauses #toggl3 a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#internetuses th a,#internetuses #toggl4 a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#appactivityhistory th a,#appactivityhistory #toggl5 a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});
$(function() {
        $('#deviceinfo th a,#deviceinfo #toggl7 a').live('click', function() {
        $('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);
                $.getScript(this.href);
                return false;
        });
});

$(function() {
        $('#sortdevice th a, #sortdevice #devicepaginate a').live('click', function() {
			$('#spinner').overlay({
                top: 450,
                closeOnClick: true,
                api: true
                })
                var ol = $("#spinner").overlay({api: true});
                setTimeout(function() {
                ol.load();
                }, 1);               
			$.getScript(this.href);
            return false;
        });
});
String.prototype.trim = function() { return this.replace(/^\s+|\s+$/g, ""); };