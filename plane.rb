class Plane < Vehicle

  def initialize(attributes={})
    mobile_setup( {wheelnum: 5, max_passengers: 'Not Available'}.merge(attributes) )
  end

end
