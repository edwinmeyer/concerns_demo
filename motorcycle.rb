class Motorcycle < Vehicle

  def initialize(attributes={})
    mobile_setup( {wheelnum: 2, max_passengers: 2}.merge(attributes) )
  end

end
