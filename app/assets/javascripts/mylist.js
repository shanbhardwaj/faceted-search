var wine_quick = false;
var chk = false;
jQuery(document).ready(function(){
	jQuery("#clearfilter").click(function(){
		jQuery(this).hide();
		jQuery("#browse_1").removeClass('addcross');
		jQuery("#browse_2").removeClass('addcross');
		jQuery("#browse_3").removeClass('addcross');
		jQuery("#browse_4").removeClass('addcross');
		jQuery("#browse_5").removeClass('addcross');
		jQuery(".wineyear").removeClass('addcross');
		jQuery(".winesubregion").removeClass('addcross');
		jQuery(".redvaritel").removeClass('addcross');
		jQuery(".whitevaritel").removeClass('addcross');
		jQuery(".sparkvaritel").removeClass('addcross');
		jQuery(".winesize").removeClass('addcross');
		jQuery(".winestyle").removeClass('addcross');
		jQuery(".wineregion").removeClass('addcross');
		jQuery(".winereviewed").removeClass('addcross');
		jQuery(".winepairing").removeClass('addcross');
		jQuery(".winerating").removeClass('addcross');
		jQuery(".winetype").removeClass('addcross');
		jQuery(".winedistance").removeClass('addcross');
		jQuery(".wineprice").removeClass('addcross');
		
		$("#retailertype_store_input").attr('checked', false);
		$("#retailertype_restaurant_input").attr('checked', false);
		$("#retailertype_online_input").attr('checked', false);
	});

	jQuery("#browse_all").click(function(){
		toggleQuickSearchFilter(true);

		if (jQuery(this).hasClass('addcross')){
			jQuery(this).removeClass('addcross');
			chk = true;
			jQuery('#' + 'selectedFilter_' + jQuery(this).attr('id')).click();
		}else{
			jQuery(this).addClass('addcross');
			jQuery(this).css("background-position", $(this).children().first().width()+10);
			add2selectedFilters(this, true);
		}
	});
	jQuery("#browse_buy").click(function(){
		toggleQuickSearchFilter(true);

		if (jQuery(this).hasClass('addcross')){
			jQuery(this).removeClass('addcross');
			chk = true;
			jQuery('#' + 'selectedFilter_' + jQuery(this).attr('id')).click();
		}else{
			jQuery(this).addClass('addcross');
			jQuery(this).css("background-position", $(this).children().first().width()+10);
			add2selectedFilters(this, true);
		}
	});
	jQuery("#browse_fav").click(function(){
		toggleQuickSearchFilter(true);

		if (jQuery(this).hasClass('addcross')){
			jQuery(this).removeClass('addcross');
			chk = true;
			jQuery('#' + 'selectedFilter_' + jQuery(this).attr('id')).click();
		}else{
			jQuery(this).addClass('addcross');
			jQuery(this).css("background-position", $(this).children().first().width()+10);
			add2selectedFilters(this, true);
		}
	});
	jQuery("#browse_like").click(function(){
		toggleQuickSearchFilter(true);

		if (jQuery(this).hasClass('addcross')){
			jQuery(this).removeClass('addcross');
			chk = true;
			jQuery('#' + 'selectedFilter_' + jQuery(this).attr('id')).click();
		}else{
			jQuery(this).addClass('addcross');
			jQuery(this).css("background-position", $(this).children().first().width()+10);
			add2selectedFilters(this, true);
		}
	});
	jQuery("#browse_spark").click(function(){
		toggleQuickSearchFilter(true);

		if (jQuery(this).hasClass('addcross')){
			jQuery(this).removeClass('addcross');
		}else{
			jQuery(this).addClass('addcross');
			jQuery(this).css("background-position", $(this).children().first().width()+10)

			add2selectedFilters(this, true);
		}
	});
	jQuery("#browse_high").click(function(){
		toggleQuickSearchFilter(true);

		if (jQuery("#browse_high").hasClass('addcross')){
			jQuery(this).removeClass('addcross');
			jQuery("#retailerprice_5000").removeClass('addcross');
			chk = true;
			jQuery('#' + 'selectedFilter_' + jQuery(this).attr('id')).click();
		}else{
			jQuery(this).addClass('addcross');
			jQuery(this).css("background-position", $(this).children().first().width()+10);
			jQuery("#retailerprice_5000").addClass('addcross');
			jQuery("#retailerprice_5000").css("background-position", $("#retailerprice_5000").children().first().width()+10);

			add2selectedFilters(this, true);
		}
	});
	jQuery(".searchFilter").click(function(){
		if (jQuery(this).hasClass('wineprice')) return;
		if (jQuery(this).hasClass('winerating')) return;
		if (jQuery(this).hasClass('winetype')) return;
		if (jQuery(this).hasClass('retailertype')) return;

		toggleQuickSearchFilter(false);

		if (jQuery(this).hasClass('addcross')){
			jQuery(this).removeClass('addcross');
			chk = true;
			jQuery('#' + 'selectedFilter_' + jQuery(this).attr('id')).click();
		}else{
			jQuery(this).addClass('addcross');
			jQuery(this).css("background-position", $(this).children().first().width()+10)

			add2selectedFilters(this, false);
		}
	});
});
function add2selectedFilters(item, quickSearchFilter){
	selItem = jQuery(item).parent().clone();
	selItem.attr('tag', selItem.children().first().attr('id'));
	selItem.attr('id', "selectedFilter_" + selItem.children().first().attr('id'));
	selItem.removeAttr('onclick');
	selItem.removeAttr('href');
	selItem.click(function(){
		if(!chk) jQuery('#' + jQuery(this).attr('tag')).click(); else chk = false;

		if(jQuery("#selectedFilters").children().first().text() == jQuery(this).parent().text() && jQuery("#selectedFilters").children().length > 1){
			jQuery(this).parent().next().children().first().remove();
		}
		jQuery(this).parent().remove();
		return false;
	});
	li = document.createElement('li');
	if(quickSearchFilter) jQuery(li).addClass('quickSelectedFilter'); else jQuery(li).addClass('selectedFilter');
	if(jQuery("#selectedFilters").text() != "") jQuery(li).html("<span>, </span>");
	selItem.appendTo(jQuery(li));
	selItem.children().first().find('span').eq(1).remove();
	if (selItem.children().first().html()) selItem.html(selItem.children().first().html().replace(/&nbsp;/g, '').trim());
	jQuery(li).appendTo("#selectedFilters");
}
function toggleQuickSearchFilter(quick_click){
	if(!wine_quick && quick_click) {
		jQuery(".searchFilter").removeClass('addcross');
		$(".retailertype").removeClass('checkboximage');$(".retailertype").addClass('checkboxuncheckedimage');
		jQuery(".selectedFilter").remove();
		
		wine_quick = true;
	}else if(wine_quick && !quick_click){
		jQuery(".quickSearchFilter").removeClass('addcross');
		jQuery(".quickSelectedFilter").remove();
		jQuery(".searchFilter").each(function(index) {
			if(jQuery(this).hasClass('addcross')){
			    add2selectedFilters(this, false);
			}
		});
		wine_quick = false;
	}
}
function togglespiner(showHideDiv) {
	var ele = document.getElementById(showHideDiv);
	if(ele.style.display == "block") {
		ele.style.display = "none";
	}else {
		ele.style.display = "block";
	}
}

