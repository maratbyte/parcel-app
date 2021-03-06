require "test_helper"

class ParcelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parcel = parcels(:one)
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
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get parcels_url
    assert_response :success
  end

  test "should get new" do
    get new_parcel_url
    assert_response :success
  end

  test "should create parcel" do
    assert_difference('Parcel.count') do
      post parcels_url, params: {
        parcel: {
          origin: @parcel.origin,
          destination: @parcel.destination,
          weight: @parcel.weight,
          height: @parcel.height,
          length: @parcel.length,
          width: @parcel.width,
          first_name: @parcel.first_name,
          last_name: @parcel.last_name,
          phone_number: @parcel.phone_number,
          email: @parcel.email
        }
      }
    end
    assert_redirected_to parcel_url(Parcel.last)
    assert_equal "Parcel was successfully created.", flash[:notice]
  end

  test "should show parcel" do
    get parcel_url(@parcel)
    assert_response :success
  end

  test "should get edit" do
    get edit_parcel_url(@parcel)
    assert_response :success
  end

  test "should update parcel" do
    patch parcel_url(@parcel), params: {
      parcel: {
        origin: @parcel.origin,
        destination: @parcel.destination,
        weight: @parcel.weight,
        height: @parcel.height,
        length: @parcel.length,
        width: @parcel.width,
        first_name: "Updated Name",
        last_name: @parcel.last_name,
        phone_number: @parcel.phone_number,
        email: @parcel.email
      }
    }
    assert_redirected_to parcel_url(@parcel)
    assert_equal "Parcel was successfully updated.", flash[:notice]
    @parcel.reload
    assert_equal "Updated Name", @parcel.first_name
  end

  test "should destroy parcel" do
    assert_difference('Parcel.count', -1) do
      delete parcel_url(@parcel)
    end
    assert_redirected_to parcels_url
    assert_equal "Parcel was successfully destroyed.", flash[:notice]
  end
end
