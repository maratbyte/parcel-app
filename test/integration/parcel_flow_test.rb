require "test_helper"

class ParcelFlowTest < ActionDispatch::IntegrationTest
  setup do
    @parcel = parcels(:one)
  end

  test "visiting parcels index" do
    get parcels_path
    assert_select "h1", "All Parcels"
  end

  test "creating new Parcel" do
    get new_parcel_path
    assert_response :success

    post parcels_path, params: {
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
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span.alert-message", "Parcel was successfully created."
  end

  test "updating a Parcel" do
    get edit_parcel_path(@parcel)
    assert_response :success

    patch parcel_path(@parcel), params: {
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
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span.alert-message", "Parcel was successfully updated."
  end

  test "destroying a Parcel" do
    delete parcel_path(@parcel)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span.alert-message", "Parcel was successfully destroyed."
  end
end
