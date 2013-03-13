/* go top */
var map;
function GoUpButton(gmap) {
map = gmap;
    // var button = $("<input type='button'>");

    var button = $('<div class="custom_nav_top" onclick="panup();"></div>');
    var div = $('<div onclick="panup();"></div>')
        .append(button);
	
    return div.get(0);
}

/* go down */
function GoDownButton() {
   // var button = $("<input type='button' class='custom_nav_down'>");

    var button = $('<div class="custom_nav_down" onclick="pandown();"></div>');
    var div = $('<div onclick="pandown();"></div>')
        .append(button);

    return div.get(0);

}

/* go left */
function GoLeftButton() {
   // var button = $("<input type='button' class='custom_nav_left'>");

    var button = $('<div class="custom_nav_left" onclick="panleft();"></div>');
    var div = $('<div onclick="panleft();"></div>')
        .append(button);

    return div.get(0);
}

/* go right */
function GoRightButton() {
   // var button = $("<input type='button' class='custom_nav_right'>");

    var button = $('<div class="custom_nav_right" onclick="panright();"></div>');
    var div = $('<div onclick="panright();"></div>')
        .append(button);

    return div.get(0);
}
function ZoomButton() {
   // var buttonin = $("<input type='button' class='zoomin' onclick='map.setZoom(map.getZoom() + 1);'>");
   // var buttonout = $("<input type='button' class='zoomout' onclick='map.setZoom(map.getZoom() - 1);'>");

    var buttonin = $('<div class="zoomin" onclick="zoomin();"></div>');
    var buttonout = $('<div class="zoomout" onclick="zoomout();"></div>');
    var div = $('<div></div>').append(buttonin).append(buttonout);

    return div.get(0);
}
function closewindow(){
	//$('#info').remove();
}
function zoomin(){
	closewindow();
	map.setZoom(map.getZoom() + 1);	
}
function zoomout(){
	closewindow();
	map.setZoom(map.getZoom() - 1);	
}
function panleft(){
	closewindow();
	map.panBy(-30,0);
}
function panright(){
	closewindow();
	map.panBy(30,0);	
}
function panup(){
	closewindow();
	map.panBy(0,-30);	
}
function pandown(){
	closewindow();
	map.panBy(0,30);	
}
