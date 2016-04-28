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

$(document).foundation();

var map;
var infoWindow;
var service;
var markers = [];
var results = [];
var pos;
var marker;
var placeLoc;
var locations = [];


function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14
  });

  var userLocation = new google.maps.InfoWindow({map: map});
  infoWindow = new google.maps.InfoWindow({map: map});
  service = new google.maps.places.PlacesService(map);
  infoWindow.close();


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
        radius: 5000,
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
     locations.push(results[i]);
   }
 }
}

function shuffle(array) {
  var m = array.length, t, i;
  while (m > 0) {
    i = Math.floor(Math.random() * m--);
    t = array[m];
    array[m] = array[i];
    array[i] = t;
  }
  return array[i];
}

var rando;

$(function(){
  $('#play_button').on('click', function(){
    marker.setMap(null);
    clearMarkers(markers);
    rando = shuffle(locations);
    service.getDetails({
      placeId: rando.place_id
    }, function(place, status) {
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        $('.establishment_name').replaceWith('<div class="establishment_name">'+
        '<div class="callout">'+'<ul>'+'<li>'+ '<h3>'+place.name+'</h3>' +
        '</li>'+'<li>'+place.vicinity+'</li>'+'<li>'+'<a href='+'"'+
        place.website+'"'+'>'+"Website"+'</a>'+'</li>'+'</ul>'+'</div>'+
        '</div>');
        // debugger;
      }
    });
    createMarker(rando);
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
