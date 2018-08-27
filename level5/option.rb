class Option
  OPTIONS_OWNERS = {
    'additional_insurance' => { who: 'drivy', price: 1000 },
    'gps'                  => { who: 'owner', price: 500 },
    'baby_seat'            => { who: 'owner', price: 200 }
  }.freeze

  attr_reader :type, :price, :who

  def initialize(type)
    @type = type
    @price = OPTIONS_OWNERS[type][:price]
    @who = OPTIONS_OWNERS[type][:who]
  end
end
