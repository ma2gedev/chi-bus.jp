# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("input[data-geolocation]").click (e) ->
    return if ($('#q').val() != '') # keyword search
    if (navigator.geolocation)
      navigator.geolocation.getCurrentPosition(success, error)
    else
      console.warn('Navigator.geolocation not supported.')
    false

success = (position) ->
  lat = position.coords.latitude
  long = position.coords.longitude
  window.location.href = '/bus_stops/?position=' + lat + ',' + long

error = (err) ->
  console.warn('ERROR(' + err.code + '): ' + err.message)

$ ->
  $("a[data-search-map-center]").click (e) ->
    center = handler.getMap().getCenter()
    lat = center.lat()
    long = center.lng()
    window.location.href = '/bus_stops/?position=' + lat + ',' + long
    false
