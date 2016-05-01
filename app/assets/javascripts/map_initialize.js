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
        radius: 3000,
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
