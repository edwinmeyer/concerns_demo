class QuadCopter < Vehicle

  def initialize(attributes={})
    mobile_setup( {wheelnum: 0, max_passengers: 0}.merge(attributes) )
  end

end
