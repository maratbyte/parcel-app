require 'faker'
require_relative '../lib/fake_data.rb'

10.times do
  origin = FakeData::random_city
  destination = FakeData::random_city
  while origin == destination do
    destination = FakeData::random_city
  end
  begin 
    Parcel.create(
      origin: origin,
      destination: destination,
      weight: Faker::Number.within(range: 1..100),
      height: Faker::Number.within(range: 1..100),
      length: Faker::Number.within(range: 1..100),
      width: Faker::Number.within(range: 1..100),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_number: Faker::PhoneNumber.phone_number,
      email: Faker::Internet.email
    )
  rescue => e
    puts e
  end
end