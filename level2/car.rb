require 'date'

class Car
  attr_reader :price_per_day, :price_per_km

  def initialize(price_per_day, price_per_km)
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  def price_for_rental(rental)
    (rental.price_decreased_for_price(price_per_day) + rental.distance * price_per_km).to_i
  end
end
