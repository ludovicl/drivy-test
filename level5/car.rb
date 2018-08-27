require 'date'

class Car
  attr_reader :price_per_day, :price_per_km

  def initialize(price_per_day, price_per_km)
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  def actions(rental)
    price = price_for_rental(rental)
    [
      { 'who' => 'driver',     'type' => 'debit',  'amount' => rental.driver_rental_amount(price).to_i },
      { 'who' => 'owner',      'type' => 'credit', 'amount' => rental.owner_rental_amount(price).to_i },
      { 'who' => 'insurance',  'type' => 'credit', 'amount' => rental.insurance_rental_amount(price).to_i },
      { 'who' => 'assistance', 'type' => 'credit', 'amount' => rental.assistance_rental_amount.to_i },
      { 'who' => 'drivy',      'type' => 'credit', 'amount' => rental.drivy_rental_amount(price).to_i }
    ]
  end

  private

  def price_for_rental(rental)
    (rental.price_decreased_for_price(price_per_day) + rental.distance * price_per_km).to_i
  end

end
