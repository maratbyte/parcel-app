require_relative "parcel.rb"
require_relative "utilities.rb"

KEYS = [:weight, :length, :width, :height, :origin, :destination]
UNITS = {
  weight: "kg",
  length: "cm",
  width: "cm",
  height: "cm",
  distance: "km",
  price: "rub"
}

def get_parcel_attrs(keys)
  attrs = {}
  keys.each do |key|
    if [:origin, :destination].include?(key)
      msg = "Enter #{key} city: "
      feedback = "#{key.capitalize} should be a valid city name and contain one or more words divided by either a space or a dash sign. Please try again."
      regexp = /^[a-zA-Z]+(?:[ -][a-zA-Z]+)*$/
    else
      msg = "Enter parcel #{key}: "
      feedback = "Parcel #{key} should be a whole number. Please try again."
      regexp = /^\d+$/
    end
    attrs[key] = Utilities::get_valid_input(msg, regexp, feedback)
  end
  return attrs
end

puts "\nWelcome to Parcel Delivery Service."
print "To request a shipping quote, please enter the following information.\n\n"

loop do
  begin
    attrs = get_parcel_attrs(KEYS)
    parcel = Parcel.new(attrs)
    print "\nWe successfully processed your request. Here is your shipping quote:\n\n"
    Utilities::print_pretty_hash(parcel.as_hash, UNITS)
  rescue => e
    print "\n#{e}\n\n"
  end
  puts "Would you like to make another request?(yes/no)"
  answer = gets.chomp.downcase
  puts
  if answer == "no"
    puts "Thank you for using our service."
    break
  end
end