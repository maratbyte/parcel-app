module MapboxServices
  class DistanceGetter < ApplicationService
    require 'net/http'

    DISTANCE_API = "https://api.mapbox.com/optimized-trips/v1/mapbox/driving"
    TOKEN = "pk.eyJ1IjoibWFyYXRieXRlIiwiYSI6ImNreW85bHRsdzN5MjAyd284MWtoY2k4ODEifQ.RRzfkXHcu4_Yvlequ5i-Nw"

    def initialize(origin, destination)
      @origin = origin
      @destination = destination
    end

    def call
      origin_coords = MapboxServices::CoordsGetter.call(@origin)
      destination_coords = MapboxServices::CoordsGetter.call(@destination)
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
  end
end  