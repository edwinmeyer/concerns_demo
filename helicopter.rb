class Helicopter < Vehicle

  def initialize(attributes={})
    mobile_setup( {wheelnum: 3, max_passengers: 5}.merge(attributes) )
  end

end
