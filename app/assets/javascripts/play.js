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
      }
    });
    createMarker(rando);
  });
});
