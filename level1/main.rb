require 'json'
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
        @input_data['rentals'].map do |rental|
          car = @cars_by_ids[rental['car_id']]
          {
            'id' => rental['id'],
            'price' => car.price(rental['distance'], rental['start_date'], rental['end_date'])
          }
        end
    }
  end

  private_class_method :serialize
end

