class Parcel < ApplicationRecord
  # Origin and Destination
  # can't have the same name
  validate :origin_and_destination_should_differ
  validates :origin, :destination,
    # should be valid city names and contain one or more words divided by either a space or a dash sign
    format: {
      with: /\A[a-zA-Zа-яА-Я]+(?:[ -][a-zA-Zа-яА-Я]+)*(?:, [a-zA-Zа-яА-Я]+)*\z/,
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


  def origin_and_destination_should_differ
    if origin.downcase == destination.downcase
      errors.add(:origin, "Origin and Destination should differ")
    end
  end

  
  private
    def set_distance
      data = GoogleMapsServices::DistanceMatrix.call(self.origin, self.destination)
      self.origin = data[:origin]
      self.destination = data[:destination]
      self.distance = data[:distance]
    end

    def set_price
      self.price = ParcelServices::PriceCalculator.call(self)
    end
end
