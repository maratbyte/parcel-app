# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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