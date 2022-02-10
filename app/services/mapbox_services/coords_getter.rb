module MapboxServices
  class CoordsGetter < ApplicationService
    require 'net/http'

    GEOCODING_API = "https://api.mapbox.com/geocoding/v5/mapbox.places"
    TOKEN = "pk.eyJ1IjoibWFyYXRieXRlIiwiYSI6ImNreW85bHRsdzN5MjAyd284MWtoY2k4ODEifQ.RRzfkXHcu4_Yvlequ5i-Nw"

    def initialize(location)
      @location = location
    end

    def call
      uri = URI("#{GEOCODING_API}/#{@location.gsub(/\b \b/, "%20")}.json")
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
      raise "Failed to get coordindates for #{@location}. You should enter a valid city name."
    end
  end
end