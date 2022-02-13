require "application_system_test_case"

class ParcelsTest < ApplicationSystemTestCase
  setup do
    @parcel = parcels(:one)
  end

  test "visiting the index" do
    visit parcels_url
    assert_selector "h1", text: "All Parcels"
  end

  test "creating a Parcel" do
    visit parcels_url
    click_on "New Parcel"

    fill_in "Destination", with: @parcel.destination
    fill_in "Origin", with: @parcel.origin
    fill_in "Weight", with: @parcel.weight
    fill_in "Height", with: @parcel.height
    fill_in "Length", with: @parcel.length
    fill_in "Width", with: @parcel.width
    fill_in "First name", with: @parcel.first_name
    fill_in "Last name", with: @parcel.last_name
    fill_in "Phone number", with: @parcel.phone_number
    fill_in "Email", with: @parcel.email
    click_on "Quote & Book"

    assert_text "Parcel was successfully created"
    click_on "All Parcels"
  end

  test "updating a Parcel" do
    visit parcels_url
    click_on "Edit", match: :first

    fill_in "Destination", with: @parcel.destination
    fill_in "Origin", with: @parcel.origin
    fill_in "Weight", with: @parcel.weight
    fill_in "Height", with: @parcel.height
    fill_in "Length", with: @parcel.length
    fill_in "Width", with: @parcel.width
    fill_in "First name", with: @parcel.first_name
    fill_in "Last name", with: @parcel.last_name
    fill_in "Phone number", with: @parcel.phone_number
    fill_in "Email", with: @parcel.email
    click_on "Save"

    assert_text "Parcel was successfully updated."
    click_on "All Parcels"
  end

  test "destroying a Parcel" do
    visit parcels_url
    click_on "Destroy", match: :first
    assert_text "Parcel was successfully destroyed."
  end
end
