require 'date'

class Car
  def initialize(price_per_day, price_per_km)
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  def price(distance, start_date, end_date)
    rental_days_nb = (Date.parse(end_date) - Date.parse(start_date) + 1).to_i
    (rental_days_nb * @price_per_day + @price_per_km * distance).to_i
  end
end
