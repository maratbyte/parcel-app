module ParcelServices
  class PriceCalculator < ApplicationService

    def initialize(parcel)
      @parcel = parcel
    end

    def call
      volume = @parcel.length * @parcel.height * @parcel.width / 1000000
      rate = volume < 1 ? 1 : @parcel.weight <= 10 ? 2 : 3
      @parcel.distance * rate
    end
  end
end