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

  def commission_for_rental(rental)
    issurance_fee = (price_for_rental(rental) * 0.3) / 2
    assistance_fee = rental.rental_days_duration * 100
    {
      'insurance_fee' => issurance_fee,
      'assistance_fee' => assistance_fee,
      'drivy_fee' => price_for_rental(rental) * 0.3 - issurance_fee - assistance_fee
    }
  end
end
