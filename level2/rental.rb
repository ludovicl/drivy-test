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
    @adjusted_price = 0
  end

  def price_decreased_for_price(price_per_day)
    return @adjusted_price if @adjusted_price != 0 # we already compute discount for this rental
    remaining_rental_days = rental_days_duration
    DISCOUNT_AFTER_DAY.map do |day, discount|
      remaining_rental_days = price_after_days(remaining_rental_days, day.to_i, discount, price_per_day)
    end
    @adjusted_price
  end

  private

  def price_after_days(rental_days_nb, from_day, discount, price_per_day)
    return rental_days_nb if rental_days_nb <= from_day.to_i
    @adjusted_price += (rental_days_nb - from_day) * discount * price_per_day
    remaining_rental_days = rental_days_nb - (rental_days_nb - from_day)
    remaining_rental_days
  end
end
