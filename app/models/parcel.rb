class Parcel < ApplicationRecord
  # Origin and Destination
  # can't have the same name
  validates :origin,
    comparison: {
      other_than: :destination,
      message: "should differ from Destination"
    }
  validates :origin, :destination,
    # should be valid city names and contain one or more words divided by either a space or a dash sign
    format: {
      with: /\A[a-zA-Z]+(?:[ -][a-zA-Z]+)*\z/,
      message: "should contain one or more words divided by spaces or dashes"
    },
    # can't have more than 85 characters
    length: {
      maximum: 85,
      message: "can't have more than %{count} characters"
    },
    # are required
    presence: true
  
  
  # Parcel measurements
  validates :weight, :height, :length, :width,
    # should be positive integers in range 1...300
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than: 300
    },
    # are required
    presence: true
  
  # Other attributes
  validates :first_name, :last_name, :phone_number, :email,
    # are required
    presence: true


  before_save :set_distance, :set_price

  
  private
    def set_distance
      self.distance = MapboxServices::DistanceGetter.call(self.origin, self.destination)
    end

    def set_price
      self.price = ParcelServices::PriceCalculator.call(self)
    end
end
