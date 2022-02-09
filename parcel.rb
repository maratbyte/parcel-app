require_relative "utilities.rb"

class Parcel
  attr_reader :price
  def initialize(attrs)
    @weight = attrs.fetch(:weight).to_i
    @length = attrs.fetch(:length).to_i
    @width = attrs.fetch(:width).to_i
    @height = attrs.fetch(:height).to_i
    @origin = attrs.fetch(:origin)
    @destination = attrs.fetch(:destination)
    @distance = Utilities::get_distance(@origin, @destination)
    @price = get_price
  end

  def as_hash
    {
      weight: @weight,
      length: @length,
      width: @width,
      height: @height,
      distance: @distance,
      price: @price
    }
  end

  private
    def get_price
      volume = @length * @height * @width / 1000000
      rate = volume < 1 ? 1 : @weight <= 10 ? 2 : 3
      @distance * rate
    end
end