module Mobile
  # puts "Hello from module Mobile"
  def self.included(mod)
    # puts "#{self} included in #{mod}"
  end

  attr_accessor :wheelnum, :max_passengers, :age, :manufacturer, :model_num

  def is_mobile?
    true
  end

  def is_electric?
    self.class.to_s[/^Electric/]
  end

  WHEELNUM_DEFAULT = 4
  MAX_PASSENGERS_DEFAULT = 6
  AGE_DEFAULT = MANUFACTURER_DEFAULT = MODEL_NUM_DEFAULT ='Not Available'
  def mobile_setup(attributes = {})
    [:wheelnum, :max_passengers, :age, :manufacturer, :model_num].each do |attr|
      if attributes.include? attr
        instance_eval("@#{attr} = attributes['#{attr}'.to_sym]")
      else
        instance_eval("@#{attr} = #{attr.to_s.upcase}_DEFAULT")
      end
    end
  end

end

