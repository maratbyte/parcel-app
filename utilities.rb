require "net/http"
require "json"

module Utilities
  # Mapbox API
  GEOCODING_API = "https://api.mapbox.com/geocoding/v5/mapbox.places"
  DISTANCE_API = "https://api.mapbox.com/optimized-trips/v1/mapbox/driving"
  TOKEN = "pk.eyJ1IjoibWFyYXRieXRlIiwiYSI6ImNreW85bHRsdzN5MjAyd284MWtoY2k4ODEifQ.RRzfkXHcu4_Yvlequ5i-Nw"

  def self.get_coords(location)
    uri = URI("#{GEOCODING_API}/#{location.gsub(/\b \b/, "%20")}.json")
    params = {
      access_token: TOKEN,
      limit: 1
    }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)["features"]
      unless data.empty?
        return data.first["center"]
      end
    end
    raise "Failed to get coordindates for #{location}. You should enter a valid city name."
  end

  def self.get_distance(origin, destination)
    origin_coords = get_coords(origin)
    destination_coords = get_coords(destination)
    coords = "#{origin_coords.join(',')};#{destination_coords.join(',')}"
    uri = URI("#{DISTANCE_API}/#{coords}")
    params = {access_token: TOKEN}
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      if data["trips"].nil?
        raise "Parcel can't be delivered. #{data["message"]}."
      end
      distance = data["trips"].first["distance"]
      if  distance.zero?
        raise "Parcel can't be delivered. Distance between #{origin} and #{destination} is zero."
      end
      return (distance / 1000).round
    end
    raise "Failed to get distance between #{@origin} and #{@destination}. Please try again."
  end

  # IO
  def self.get_valid_input(msg, regexp, feedback)
    print msg
    input = gets.chomp
    until input =~ regexp do
      print "\n#{feedback}\n\n"
      print msg
      input = gets.chomp
    end
    return input
  end
  
  def self.print_pretty_hash(hash, units={})
    longest_key = hash.keys.reduce do |memo, key|
      memo.length > key.length ? memo : key
    end
    hash.each do |key, value|
      padded_key = key.to_s.capitalize.ljust(longest_key.length, ' ')
      puts "#{padded_key} | #{value}#{units[key]}"
    end
    puts
  end
end