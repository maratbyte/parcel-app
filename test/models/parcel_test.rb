require "test_helper"

class ParcelTest < ActiveSupport::TestCase
  test "invalid if any of the fields is empty" do
    parcel = Parcel.new(
      origin: "",
      destination: "",
      weight: "",
      height: "",
      length: "",
      width: "",
      first_name: "",
      last_name: "",
      phone_number: "",
      email: ""
    )
    parcel.valid?
    assert_not parcel.errors[:origin].empty?
    assert_not parcel.errors[:destination].empty?
    assert_not parcel.errors[:weight].empty?
    assert_not parcel.errors[:height].empty?
    assert_not parcel.errors[:length].empty?
    assert_not parcel.errors[:width].empty?
    assert_not parcel.errors[:first_name].empty?
    assert_not parcel.errors[:last_name].empty?
    assert_not parcel.errors[:phone_number].empty?
    assert_not parcel.errors[:email].empty?
  end

  test "invalid if origin and destination are equal" do
    parcel = Parcel.new(
      origin: "Austin",
      destination: "Austin",
      weight: 50,
      height: 100,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    parcel.valid?
    assert_not parcel.errors[:origin].empty?
  end

  test "invalid if city name contains anything other than letters, spaces, commas and dashes" do
    parcel = Parcel.new(
      origin: "Huston322",
      destination: "Dallas!!!",
      weight: 50,
      height: 100,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    parcel.valid?
    assert_not parcel.errors[:origin].empty?
    assert_not parcel.errors[:destination].empty?
  end

  test "valid if origin and destination are valid city names" do
    parcel = Parcel.new(
      origin: "Huston",
      destination: "Dallas",
      weight: 50,
      height: 100,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    parcel.valid?
    assert_empty parcel.errors[:origin]
    assert_empty parcel.errors[:destination]
  end

  test "valid if origin and destination are city names with comma separated State or Country" do
    parcel = Parcel.new(
      origin: "Los Angeles, California",
      destination: "Moscow, Russia",
      weight: 50,
      height: 100,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    parcel.valid?
    assert_empty parcel.errors[:origin]
    assert_empty parcel.errors[:destination]
  end

  test "invalid if city name is longer than 85 characters" do
    parcel = Parcel.new(
      origin: "dklsfjsldkfjlskdjfklsdjfklsdjfklsdjfalkdfjsdklafjskldfjlksdjfklsdjfklsdjflksjdflksjdflksadfjlksdjflk",
      destination: "Moscow, Russia",
      weight: 50,
      height: 100,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    parcel.valid?
    assert_not parcel.errors[:origin].empty?
  end

  test "invalid if any of the measurements is not a whole number" do
    parcel = Parcel.new(
      origin: "Huston",
      destination: "Dallas",
      weight: "sldkjf",
      height: 14.37,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    parcel.valid?
    assert_not parcel.errors[:weight].empty?
    assert_not parcel.errors[:height].empty?
  end

  test "invalid if any of the measurements is outside of range 1..300" do
    parcel = Parcel.new(
      origin: "Huston",
      destination: "Dallas",
      weight: 500,
      height: 0,
      length: -37,
      width: 300,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    parcel.valid?
    assert_not parcel.errors[:weight].empty?
    assert_not parcel.errors[:height].empty?
    assert_not parcel.errors[:length].empty?
  end

  test "that distance and price are set before save" do
    parcel = Parcel.create(
      origin: "Huston",
      destination: "Dallas",
      weight: 25,
      height: 50,
      length: 50,
      width: 50,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    assert_not_nil parcel.distance
    assert_not_nil parcel.price
  end

  test "that when volume is less than one price equals distance" do
    parcel = Parcel.create(
      origin: "Huston",
      destination: "Dallas",
      weight: 25,
      height: 50,
      length: 50,
      width: 50,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    assert_equal parcel.price, parcel.distance
  end

  test "that when volume is greater or equal to 1 and weight is less or equal to 10 price is double of distance" do
    parcel = Parcel.create(
      origin: "Huston",
      destination: "Dallas",
      weight: 10,
      height: 100,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    assert_equal parcel.price, parcel.distance * 2
  end

  test "that when volume is greater or equal to 1 and weight is greater than 10 price is triple of distance" do
    parcel = Parcel.create(
      origin: "Huston",
      destination: "Dallas",
      weight: 50,
      height: 100,
      length: 100,
      width: 100,
      first_name: "John",
      last_name: "Doe",
      phone_number: "970345893275",
      email: "john@doe.com"
    )
    assert_equal parcel.price, parcel.distance * 3
  end
end
