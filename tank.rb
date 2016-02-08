class Tank < Vehicle

  include ::Weapons

  def initialize(attributes={})
    mobile_setup( {wheelnum: 0, max_passengers: 5}.merge(attributes) )
    weapons_setup( {max_ammo: 30}.merge(attributes) )
  end

end
