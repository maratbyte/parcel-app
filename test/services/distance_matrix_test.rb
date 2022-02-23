require 'test_helper'

class DistanceMatrixTest < ActiveSupport::TestCase
  test "returns distance from stubbed body" do
    body = '{
      "destination_addresses": [
        "Vancouver, BC, Canada"
      ],
      "origin_addresses": [
        "Seattle, WA, USA"
      ],
      "rows": [
        {
          "elements": [
            {
              "distance": {
                "text": "229 km",
                "value": 229458
              },
              "duration": {
                "text": "2 hours 35 mins",
                "value": 9288
              },
              "status": "OK"
            }
          ]
        }
      ],
      "status": "OK"
    }'
    stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=Vancouver&key=AIzaSyAW3tBJay7F7PS6KUG9Yy2GwL1xYg8PeNY&origins=Seattle&units=metric").
      to_return(status: 200, body: body, headers: {})

    parcel = parcels(:one)
    data = GoogleMapsServices::DistanceMatrix.call(parcel.origin, parcel.destination)
    assert_equal 229, data[:distance]
    assert_equal "Vancouver, BC, Canada", data[:destination]
    assert_equal "Seattle, WA, USA", data[:origin]
  end
end