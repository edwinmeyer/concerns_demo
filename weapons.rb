module Weapons
  attr_reader :remaining_ammo, :max_ammo

  def self.included(mod)
    # puts "#{self} included in #{mod}"
  end

  #  # def initialize(max_ammo=MAX_AMMO_DEFAULT)
  #  #  @max_ammo = max_ammo
  #  #  @remaining_ammo = @max_ammo
  # end

  MAX_AMMO_DEFAULT = 30
  def weapons_setup(attributes = {})
    [:max_ammo].each do |attr|
      if attributes.include? attr
        instance_eval("@#{attr} = attributes['#{attr}'.to_sym]")
      else
        instance_eval("@#{attr} = #{attr.to_s.upcase}_DEFAULT")
      end
    end
    @remaining_ammo = @max_ammo
  end

  def has_weapons?
    true
  end

  def shoot!
    if @remaining_ammo > 0
      puts "Bang!"
      @remaining_ammo -= 1
      true
    else
      puts "Click!"
      false
    end
  end

  def reload!
    @remaining_ammo = @max_ammo
  end
end
