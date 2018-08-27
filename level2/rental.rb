class Rental

  attr_reader :distance, :rental_days_duration

  DISCOUNT_AFTER_DAY = {
    '10' => 0.5,
    '4' => 0.7,
    '1' => 0.9,
    '0' => 1
  }.freeze

  def initialize(distance, start_date, end_date)
    @distance = distance
    @rental_days_duration = (end_date - start_date + 1).to_i
  end

  def price_decreased_for_price(price_per_day)
    adjusted_price = 0
    remaining_rental_days = rental_days_duration
    DISCOUNT_AFTER_DAY.map do |day, discount|
      adjusted_price, remaining_rental_days = price_after_days(remaining_rental_days,
                                                               day.to_i, discount, adjusted_price, price_per_day)
    end
    adjusted_price
  end

  private

  def price_after_days(rental_days_nb, from_day, discount, adjusted_price, price_per_day)
    return [0, rental_days_nb] if rental_days_nb <= from_day.to_i
    adjusted_price += (rental_days_nb - from_day) * discount * price_per_day
    remaining_rental_days = rental_days_nb - (rental_days_nb - from_day)
    [adjusted_price, remaining_rental_days]
  end
end