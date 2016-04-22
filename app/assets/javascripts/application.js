// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

var map;
var infoWindow;
var userLocation;
var service;
var markers = [];
var results = [];
var names = [];
var pos;
var marker;
var placeLoc;
var locations = [];

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    // center: {lat: -34.397, lng: 150.644},
    zoom: 14
  });
  infoWindow = new google.maps.InfoWindow({map: map});
  userLocation = new google.maps.InfoWindow({map: map});
  service = new google.maps.places.PlacesService(map);

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      userLocation.setPosition(pos);
      userLocation.setContent('You..');
      map.setCenter(pos);
      service.nearbySearch({
        location: pos,
        radius: 1000,
        types: ['restaurant', 'cafe']
      }, callback);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
      handleLocationError(false, infoWindow, map.getCenter());
    }

  google.maps.event.addListener(map, 'rightclick', function(event) {
    marker.setMap(null);
    map.setCenter(event.latLng);
    clearResults(markers);
    locations = [];
    service.nearbySearch({
      location: event.latLng,
      radius: 1000,
      types: ['restaurant', 'cafe']
    }, callback);
  });
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
       infoWindow.setPosition(pos);
       infoWindow.setContent(browserHasGeolocation ?
                             'Error: The Geolocation service failed.' :
                             'Error: Your browser doesn\'t support geolocation.');
     }

function callback(results, status) {
  if (status === google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      markers.push(createMarker(results[i]));
      names.push(results[i].name);
      locations.push(results[i]);
    }
  }
}

// function shuffle(array) {
//   var m = array.length, t, i;
//   while (m > 0) {
//     i = Math.floor(Math.random() * m--);
//     t = array[m];
//     array[m] = array[i];
//     array[i] = t;
//   }
//   return array[i];
// }

function shuffle(array) {
    for (var i = 0; i < array.length - 1; i++) {
        var j = i + Math.floor(Math.random() * (array.length - i));

        var temp = array[j];
        array[j] = array[i];
        array[i] = temp;
    }
    return array[j];
}

var rando;

$(function(){
  $('#showbutton').on('click', function(){
    marker.setMap(null);
    clearMarkers(markers);
    rando = shuffle(locations);
    createMarker(rando);
    $('.establishment_name').replaceWith('<div class="establishment_name">'+
    '<ul>'+'<li>'+ rando.name +'</li>'+'<li>'+ rando.vicinity +'</li>'+'</ul>'+
    '</div>');
  });
});

function createMarker(place) {
  placeLoc = place.geometry.location;
  marker = new google.maps.Marker({
    map: map,
    animation: google.maps.Animation.DROP,
    position: placeLoc
  });

  google.maps.event.addListener(marker, 'click', function() {
    infoWindow.setContent(place.name);
    infoWindow.open(map, this);
  });
  return marker;
}

function clearResults(markers) {
  for (var m in markers) {
    markers[m].setMap(null);
  }
  markers = [];
  names = [];
}

function clearMarkers(markers) {
  for (var m in markers) {
    markers[m].setMap(null);
  }
  markers = [];
}
