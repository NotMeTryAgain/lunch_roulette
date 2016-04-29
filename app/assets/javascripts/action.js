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
