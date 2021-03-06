require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "should build_markers return empty" do
    results = build_markers([])
    assert_equal [], results
  end

  test "should build_markers return bus stops markers" do
    bus_stops = [
      BusStop.new(id: 1, latitude: 3.5, longitude: 4.5, name: 'name_1'),
      BusStop.new(id: 2, latitude: 5.5, longitude: 6.5, name: 'name_2')
    ]
    results = build_markers(bus_stops)
    assert_equal 2, results.length

    assert_equal 1, results[0][:id]
    assert_equal 3.5, results[0][:lat]
    assert_equal 4.5, results[0][:lng]
    assert_equal 'name_1', results[0][:marker_title]
    assert results[0][:infowindow]

    assert_equal 2, results[1][:id]
    assert_equal 5.5, results[1][:lat]
    assert_equal 6.5, results[1][:lng]
    assert_equal 'name_2', results[1][:marker_title]
    assert results[1][:infowindow]
  end

  test "should build_markers return position markers" do
    results = build_markers([], '1.5,2.5')
    assert_equal 1, results.length

    assert_equal '1.5', results[0][:lat]
    assert_equal '2.5', results[0][:lng]
    assert_equal '/images/bluedot.png', results[0][:picture][:url]
    assert_equal '20', results[0][:picture][:width]
    assert_equal '20', results[0][:picture][:height]
  end

  test "should build_markers return bus stops and position markers" do
    results = build_markers([BusStop.new(id: 1)], '1.5,2.5')
    assert_equal 2, results.length
  end

  test "shuld build_routes_hash return empty" do
    results = build_routes_hash([])
    assert_equal [], results
  end

  test "shuld build_routes_hash return bus route hash" do
    bus_routes = [
      BusRoute.new(id: 1) { |bus_route| bus_route.bus_route_tracks << BusRouteTrack.new(coordinates: [[1.5, 2.5]]) },
      BusRoute.new(id: 2) { |bus_route| bus_route.bus_route_tracks << BusRouteTrack.new(coordinates: [[3.5, 4.5]]) }
    ]

    results = build_routes_hash(bus_routes)
    assert_equal [{ id: 1, tracks: [[{ lat: 1.5, lng: 2.5 }]]}, { id: 2, tracks: [[{ lat: 3.5, lng: 4.5 }]] }], results
  end

  test "should gravatar_for return html" do
    render text: gravatar_for('test@exsample.com', 200)
    assert_select 'img[src="https://secure.gravatar.com/avatar/a90bd84d6878b3b19e23d2aa052935af?s=200"]'
    assert_select 'img[class="gravatar"]'
  end
end
