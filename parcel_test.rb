require "minitest/autorun"
require_relative "parcel.rb"

class TestParcel < Minitest::Test
  # test that price is properly calculated
  # when volume < 1 && weight <= 10
  def test_price_when_volume_lt_1_weight_lte_10
    parcel = Parcel.new({
      weight: 10,
      length: 99,
      width: 100,
      height: 100,
      origin: "Vancouver",
      destination: "Seattle"
    })
    assert_equal 454, parcel.price
  end

  # when volume < 1 && weight > 10
  def test_price_when_volume_lt_1_weight_gt_10
    parcel = Parcel.new({
      weight: 50,
      length: 99,
      width: 100,
      height: 100,
      origin: "Vancouver",
      destination: "Seattle"
    })
    assert_equal 454, parcel.price
  end

  # when volume >= 1 && weight <= 10
  def test_price_when_volume_gte_1_weight_lte_10
    parcel = Parcel.new({
      weight: 10,
      length: 100,
      width: 100,
      height: 100,
      origin: "Vancouver",
      destination: "Seattle"
    })
    assert_equal 454*2, parcel.price
  end

  # when volume >= 1 && weight > 10
  def test_price_when_volume_gte_1_weight_gt_10
    parcel = Parcel.new({
      weight: 50,
      length: 100,
      width: 100,
      height: 100,
      origin: "Vancouver",
      destination: "Seattle"
    })
    assert_equal 454*3, parcel.price
  end


  # test that instance as hash conforms to the specified format
  def test_that_instance_as_hash_has_only_needed_keys
    parcel = Parcel.new({
      weight: 10,
      length: 100,
      width: 100,
      height: 100,
      origin: "Vancouver",
      destination: "Seattle"
    })
    assert_equal [:weight, :length, :width, :height, :distance, :price], parcel.as_hash.keys
  end

  def test_that_instance_as_hash_has_numerical_values
    parcel = Parcel.new({
      weight: 10,
      length: 100,
      width: 100,
      height: 100,
      origin: "Vancouver",
      destination: "Seattle"
    })
    assert parcel.as_hash.values.all? {|value| value.is_a? Integer}
  end
end