module GoogleMapsServices
  class DistanceMatrix < ApplicationService
    class ConnectionError < StandardError; end
    class RequestError < StandardError; end
    class RouteError < StandardError; end

    require 'net/http'

    API_KEY = "AIzaSyAW3tBJay7F7PS6KUG9Yy2GwL1xYg8PeNY"
    BASE_URL = "https://maps.googleapis.com/maps/api/distancematrix/json"

    def initialize(origin, destination)
      @origin = origin
      @destination = destination
    end

    def call
      uri = URI(BASE_URL)
      params = {
        origins: @origin,
        destinations: @destination,
        units: "metric",
        key: API_KEY
      }
      uri.query = URI.encode_www_form(params)

      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        data = JSON.parse(response.body)

        if data["status"] == "OK"
          route = data["rows"].first["elements"].first

          case route["status"]
          when "OK"
            return {
              origin: data["origin_addresses"].first,
              destination: data["destination_addresses"].first,
              distance: route["distance"]["value"] / 1000
            }
          when "NOT_FOUND"
            if data["origin_addresses"].first.blank?
              raise RouteError, "Failed to locate the origin city."
            end
            raise RouteError, "Failed to locate the destination city."
          when "ZERO_RESULTS"
            raise RouteError, "No route could be found between the origin and destination."
          when "MAX_ROUTE_LENGTH_EXCEEDED"
            raise RouteError, "Requested route is too long and cannot be processed"
          end
        end
        raise RequestError, data["status"]
      end
      raise ConnectionError
    end
  end
end  