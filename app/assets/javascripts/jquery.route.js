/**
 * jQuery routeMap v3
 *
 * @url         http://www.addvalsolutions.com
 * @author      ajay.singh@addvalsolutions.com
 * @version     3.2.0
 * @date        12.12.2011
 */
/*jslint white: true, undef: true, regexp: true, plusplus: true, bitwise: true, newcap: true, strict: true, devel: true, maxerr: 50, indent: 4 */
/*global window, jQuery, $, google, $googlemaps */
(function ($) {
    "use strict";

    // global google maps objects
    var $googlemaps = google.maps,
        $geocoder = new $googlemaps.Geocoder(),
        $markersToLoad = 0,
        methods = {}; // for JSLint
    methods = {
        init: function (options) {
            var k,
            // Build main options before element iteration
            opts = $.extend({}, $.fn.routeMap.defaults, options);

                // recover icon array
                for (k in $.fn.routeMap.defaults.icon) {
                    if(!opts.icon[k]) {
                        opts.icon[k] = $.fn.routeMap.defaults.icon[k];
                    }
                }

            // Iterate through each element
            return this.each(function () {
                var $this = $(this),
                    center = methods._getMapCenter.apply($this, [opts]),
                    i, $data;

                if (opts.zoom == "fit") {
                    opts.zoom = methods.autoZoom.apply($this, [opts]);
                }

                var  mapOptions = {
                        zoom: opts.zoom,
                        center: center,
                        mapTypeControl: opts.mapTypeControl,
                        zoomControl: opts.zoomControl,
                        panControl : opts.panControl,
                        scaleControl : opts.scaleControl,
                        streetViewControl: opts.streetViewControl,
                        mapTypeId: opts.maptype,
                        scrollwheel: opts.scrollwheel,
                        maxZoom: opts.maxZoom,
                        minZoom: opts.minZoom,
			zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL,
     					      position: google.maps.ControlPosition.TOP_LEFT
					    }
                    },
                    // Create map and set initial options
                    $rgmap = new $googlemaps.Map(this, mapOptions);
		    map = $rgmap;
		    $rgmap.controls[google.maps.ControlPosition.TOP_CENTER].push(new GoUpButton($rgmap));
		    $rgmap.controls[google.maps.ControlPosition.BOTTOM_CENTER].push(new GoDownButton());
		    $rgmap.controls[google.maps.ControlPosition.LEFT_CENTER].push(new GoLeftButton());
		    $rgmap.controls[google.maps.ControlPosition.RIGHT_CENTER].push(new GoRightButton());
		    $rgmap.controls[google.maps.ControlPosition.LEFT_TOP].push(new ZoomButton());

                if (opts.log) {console.log('map center is:'); }
                if (opts.log) {console.log(center); }

                // Create map and set initial options

                $this.data("$rgmap", $rgmap);

                $this.data('gmap', {
                    'opts': opts,
                    'gmap': $rgmap,
                    'markers': [],
                    'markerKeys' : {},
                    'infoWindow': null
                });

                // Check for map controls
                if (opts.controls.length !== 0) {
                    // Add custom map controls
                    for (i = 0; i < opts.controls.length; i += 1) {
                        $rgmap.push(opts.controls[i].div);
                    }
                }

                if (opts.markers.length !== 0) {
                    // Loop through marker array
                    methods.addMarkers.apply($this, [opts.markers]);
                }

                methods._onComplete.apply($this, []);
            });
        },

        _onComplete: function () {
            var $data = this.data('gmap'),
                that = this;
            if ($markersToLoad !== 0) {
                window.setTimeout(function () {methods._onComplete.apply(that, []); }, 1000);
                return;
            }
            $data.opts.onComplete();
        },

        _setMapCenter: function (center) {
            var $data = this.data('gmap');
            if ($data.opts.log) {console.log('delayed setMapCenter called'); }
            if ($data.gmap !== undefined) {
                $data.gmap.setCenter(center);
            } else {
                var that = this;
                window.setTimeout(function () {methods._setMapCenter.apply(that, [center]); }, 500);
            }
        },

        _boundaries: null,

        _getBoundaries: function (opts) {
            if(methods._boundaries) {return methods._boundaries; }
            var mostN = opts.markers[0].latitude,
                mostE = opts.markers[0].longitude,
                mostW = opts.markers[0].longitude,
                mostS = opts.markers[0].latitude,
                i;

            for (i = 1; i < opts.markers.length; i += 1) {
                if(mostN > opts.markers[i].latitude) {mostN = opts.markers[i].latitude; }
                if(mostE < opts.markers[i].longitude) {mostE = opts.markers[i].longitude; }
                if(mostW > opts.markers[i].longitude) {mostW = opts.markers[i].longitude; }
                if(mostS < opts.markers[i].latitude) {mostS = opts.markers[i].latitude; }
            }

            methods._boundaries = {N: mostN, E: mostE, W: mostW, S: mostS};
            return methods._boundaries;
        },

        /**
         * Priorities order:
         * - latitude & longitude in options
         * - address in options
         * - latitude & longitude of first marker having it
         * - address of first marker having it
         * - failsafe (0,0)
         *
         * Note: with geocoding returned value is (0,0) and callback sets map center. It's not very nice nor efficient.
         *       It is quite good idea to use only first option
         */
        _getMapCenter: function (opts) {
            // Create new object to geocode addresses

            var center,
                that = this, // 'that' scope fix in geocoding
                i,
                selectedToCenter,
                most; //hoisting

            if (opts.markers.length && (opts.latitude == "fit" || opts.longitude == "fit")) {
                most = methods._getBoundaries(opts);
                center = new $googlemaps.LatLng((most.N + most.S)/2, (most.E + most.W)/2);
                return center;
            }

            if (opts.latitude && opts.longitude) {
                // lat & lng available, return
                center = new $googlemaps.LatLng(opts.latitude, opts.longitude);
                return center;
            } else {
                center = new $googlemaps.LatLng(0, 0);
            }

            // Check for address to center on
            if (opts.address) {
                // Get coordinates for given address and center the map
                $geocoder.geocode(
                    {address: opts.address},
                    function (result, status) {
                        if (status === google.maps.GeocoderStatus.OK) {
                            methods._setMapCenter.apply(that, [result[0].geometry.location]);
                        } else {
                            if (opts.log) {console.log("Geocode was not successful for the following reason: " + status); }
                        }
                    }
                );
                return center;
            }

            // Check for a marker to center on (if no coordinates given)
            if (opts.markers.length > 0) {
                selectedToCenter = null;

                for (i = 0; i < opts.markers.length; i += 1) {
                    if(opts.markers[i].setCenter) {
                        selectedToCenter = opts.markers[i];
                        break;
                    }
                }

                if (selectedToCenter === null) {
                    for (i = 0; i < opts.markers.length; i += 1) {
                        if (opts.markers[i].latitude && opts.markers[i].longitude) {
                            selectedToCenter = opts.markers[i];
                            break;
                        }
                        if (opts.markers[i].address) {
                            selectedToCenter = opts.markers[i];
                        }
                    }
                }
                // failed to find any reasonable marker (it's quite impossible BTW)
                if (selectedToCenter === null) {
                    return center;
                }

                if (selectedToCenter.latitude && selectedToCenter.longitude) {
                    return new $googlemaps.LatLng(selectedToCenter.latitude, selectedToCenter.longitude);
                }

                // Check if the marker has an address
                if (selectedToCenter.address) {
                    // Get the coordinates for given marker address and center
                    $geocoder.geocode(
                        {address: selectedToCenter.address},
                        function (result, status) {
                            if (status === google.maps.GeocoderStatus.OK) {
                                methods._setMapCenter.apply(that, [result[0].geometry.location]);
                            } else {
                                if (opts.log) {console.log("Geocode was not successful for the following reason: " + status); }
                            }
                        }
                    );
                }
            }
            return center;
        },

        setZoom: function (zoom) {
            var $map = this.data('gmap').gmap;
            if (zoom === "fit"){
                zoom = methods.autoZoom.apply($(this), []);
            }
            $map.setZoom(parseInt(zoom));
        },

        getRoute: function (options) {

            var $data = this.data('gmap'),
            $rgmap = $data.gmap,
            $directionsDisplay = new $googlemaps.DirectionsRenderer(),
            $directionsService = new $googlemaps.DirectionsService(),
            $travelModes = { 'BYCAR': $googlemaps.DirectionsTravelMode.DRIVING, 'BYBICYCLE': $googlemaps.DirectionsTravelMode.BICYCLING, 'BYFOOT': $googlemaps.DirectionsTravelMode.WALKING },
            $travelUnits = { 'MILES': $googlemaps.DirectionsUnitSystem.IMPERIAL, 'KM': $googlemaps.DirectionsUnitSystem.METRIC },
            displayObj = null,
            travelMode = null,
            travelUnit = null,
            unitSystem = null;

            // look if there is an individual or otherwise a default object for this call to display route text informations
            if(options.routeDisplay !== undefined){
                displayObj = (options.routeDisplay instanceof jQuery) ? options.routeDisplay[0] : ((typeof options.routeDisplay == "string") ? $(options.routeDisplay)[0] : null);
            } else if($data.opts.routeDisplay !== null){
                displayObj = ($data.opts.routeDisplay instanceof jQuery) ? $data.opts.routeDisplay[0] : ((typeof $data.opts.routeDisplay == "string") ? $($data.opts.routeDisplay)[0] : null);
            }

            // set route renderer to map
            $directionsDisplay.setMap($rgmap);
            if(displayObj !== null){
                $directionsDisplay.setPanel(displayObj);
            }

            // get travel mode and unit
            travelMode = ($travelModes[$data.opts.travelMode] !== undefined) ? $travelModes[$data.opts.travelMode] : $travelModes['BYCAR'];
            travelUnit = ($travelUnits[$data.opts.travelUnit] !== undefined) ? $travelUnits[$data.opts.travelUnit] : $travelUnits['KM'];

            // build request
            var request = {
                origin: options.from,
                destination: options.to,
                travelMode: travelMode,
                unitSystem: travelUnit
            };

            // send request
            $directionsService.route(request, function(result, status) {
                // show the rout or otherwise show an error message in a defined container for route text information
                if (status == $googlemaps.DirectionsStatus.OK) {
                    $directionsDisplay.setDirections(result);
                } else if(displayObj !== null){
                    $(displayObj).html($data.opts.routeErrors[status]);
                }
            });
            return this;
        },

        autoZoom: function (opts){
            var data = this.data('gmap'),
                i, boundaries, resX, resY, baseScale = 39135.758482;
            opts = data?data.opts:opts
            if (opts.log) {console.log("autozooming map");}

            boundaries = methods._getBoundaries(opts);
            resX = (boundaries.E - boundaries.W) * 111000 / this.width();
            resY = (boundaries.S - boundaries.N) * 111000 / this.height();

            for(i = 2; i < 20; i += 1) {
                if (resX > baseScale || resY > baseScale) {
                    break;
                }
                baseScale = baseScale / 2;
            }
            return i - 2;
        },


        getMarker: function (key) {
            return this.data('gmap').markerKeys[key];
        }
    };


    // Main plugin function
    $.fn.routeMap = function (method) {
        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' +  method + ' does not exist on jQuery.gmap');
        }
    };
    // Default settings
    $.fn.routeMap.defaults = {
        log:                     false,
        address:                 '',
        latitude:                null,
        longitude:               null,
        zoom:                    3,
        maxZoom: 				 null,
        minZoom: 				 null,
        markers:                 [],
        controls:                {},
        scrollwheel:             true,
        maptype:                 google.maps.MapTypeId.ROADMAP,

        mapTypeControl:          true,
        zoomControl:             true,
        panControl:              false,
        scaleControl:            false,
        streetViewControl:       true,

        singleInfoWindow:        true,

        html_prepend:            '<div class="gmap_marker">',
        html_append:             '</div>',
        icon: {
            image:               "/assets/black.png",
            iconsize:            [20, 34],
            iconanchor:          [9, 34],
            infowindowanchor:    [9, 2],
            shadow:              "/assets/shadow.png",
            shadowsize:          [37, 34]
        },

        onComplete:              function () {},

        travelMode:              'BYCAR',
        travelUnit:              'KM',
        routeDisplay:            null,
		routeErrors:			 {
                        		    'INVALID_REQUEST': 'The provided request is invalid.',
                                    'NOT_FOUND': 'One or more of the given addresses could not be found.',
                                    'OVER_QUERY_LIMIT': 'A temporary error occured. Please try again in a few minutes.',
                                    'REQUEST_DENIED': 'An error occured. Please contact us.',
                                    'UNKNOWN_ERROR': 'An unknown error occured. Please try again.',
                                    'ZERO_RESULTS': 'No route could be found within the given addresses.'
								 }

    };
}(jQuery));
