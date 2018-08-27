require 'json'
require_relative 'rental'
require_relative 'car'

class Main
  def self.execute(input_json)
    @input_data = JSON.parse(File.read(input_json))
    @cars_by_ids = @input_data['cars'].map do |car|
      { car['id'] => Car.new(car['price_per_day'], car['price_per_km']) }
    end.inject(:merge)
    serialize
  end

  def self.serialize
    {
      'rentals' =>
        @input_data['rentals'].map do |rental_data|
          rental_id_price(rental_data)
        end
    }
  end

  def self.rental_id_price(rental_data)
    car = @cars_by_ids[rental_data['car_id']]
    rental = Rental.new(rental_data['distance'], Date.parse(rental_data['start_date']),
                        Date.parse(rental_data['end_date']))
    {
      'id' => rental_data['id'],
      'price' => car.price_for_rental(rental)
    }
  end

  private_class_method :serialize, :rental_id_price
end
