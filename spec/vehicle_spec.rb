# vehicle_spec.rb
# Vehicle and all subclasses are tested here

# TODO: add proper directories to search path to avoid requiring individual files
classes_to_test = [:vehicle, :car, :motorcycle, :tank, :helicopter, :quad_copter, :plane, :electric_car, :electric_motorcycle, :electric_tank]

classes_to_test.each do |name|
  require_relative "../#{name}"
end

# Note: Only basic Vehicle functionality is tested here. Most of the concerns functionality is tested in classes_with_abilities_spec.rb

not_avail = 'Not Available'
common_defaults = {wheelnum: 4, max_passengers: 6, age: not_avail, manufacturer: not_avail, model_num: not_avail}

# Test all classes providing no value attributes with constructor
[ { klass: Vehicle, expected_defaults: common_defaults },
  { klass: Car, expected_defaults: common_defaults },
  { klass: ElectricCar, expected_defaults: common_defaults },
  { klass: Motorcycle, expected_defaults: common_defaults.merge({wheelnum: 2, max_passengers: 2 }) },
  { klass: ElectricMotorcycle, expected_defaults: common_defaults.merge({wheelnum: 2, max_passengers: 2 }) },
  { klass: Tank, expected_defaults: common_defaults.merge({wheelnum: 0, max_passengers: 5 }) },
  { klass: ElectricTank, expected_defaults: common_defaults.merge({wheelnum: 0, max_passengers: 5 }) },
  { klass: Helicopter, expected_defaults: common_defaults.merge({wheelnum: 3, max_passengers: 5 }) },
  { klass: QuadCopter, expected_defaults: common_defaults.merge({wheelnum: 0, max_passengers: 0 }) },
  { klass: Plane, expected_defaults: common_defaults.merge({wheelnum: 5, max_passengers: not_avail }) }
].each do |k_data|

  describe "#{k_data[:klass]} with no constructor attrs provided" do
    let(:vehicle) { k_data[:klass].new }

    [:is_electric?, :is_mobile?, :has_weapons?].each do |bin_attr|
      expected_truth_value = bin_attr==:is_electric? &&
            ([ElectricCar, ElectricMotorcycle, ElectricTank].include? k_data[:klass]) ||
          bin_attr==:is_mobile? ||
          bin_attr==:has_weapons? && ([Tank, ElectricTank].include?k_data[:klass])

      it "##{bin_attr} returns #{expected_truth_value}" do
        expect(vehicle.send(bin_attr)).to (expected_truth_value ? be_truthy : be_falsy)
      end
    end

    k_data[:expected_defaults].each do |attr, expected|
      specify "##{attr} returns #{expected}" do
        expect(vehicle.send attr).to eq(expected)
      end
    end

  end
end


[ {klass: Vehicle, set_attributes: {manufacturer: 'Dodge' } },
  {klass: Car, set_attributes: {manufacturer: 'REO Speedwagon', wheelnum: 6 } },
  {klass: Motorcycle, set_attributes: {manufacturer: 'Honda', age: 12 }, class_defaults: {wheelnum: 2, max_passengers: 2 } },
  {klass: Tank, set_attributes: {manufacturer: 'Ford', model_num: 'Sherman', age: 73 }, class_defaults: {wheelnum: 0, max_passengers: 5 } },
  { klass: Helicopter, set_attributes: {manufacturer: 'Bell Aerospace', age: 9, max_passengers: 8 }, class_defaults: common_defaults.merge({wheelnum: 3, max_passengers: 5 }) },
  { klass: QuadCopter, set_attributes: {manufacturer: 'Amazon', age: 2 }, class_defaults: common_defaults.merge({wheelnum: 0, max_passengers: 0 }) },
  { klass: Plane, set_attributes: {manufacturer: 'Boeing', model_num: '787', age: 3, wheelnum: 16, max_passengers: 196 }, class_defaults: common_defaults.merge({max_passengers: not_avail }) }
].each do |k_data|

  describe "#{k_data[:klass]} with constructor attrs "+k_data[:set_attributes].to_s do
    let(:vehicle) { k_data[:klass].new(k_data[:set_attributes]) }

    [:is_electric?, :is_mobile?, :has_weapons?].each do |bin_attr|
      expected_truth_value = bin_attr==:is_mobile? || (bin_attr==:has_weapons? && k_data[:klass]==Tank)
      it "##{bin_attr} returns #{expected_truth_value}" do
        expect(vehicle.send(bin_attr)).to (expected_truth_value ? be_truthy : be_falsy)
      end
    end

    expected_values = common_defaults
    expected_values.merge!(k_data[:class_defaults]) if k_data[:class_defaults] # merge defaults set by class
    expected_values.merge!(k_data[:set_attributes]) # merge expected values set by this test

    expected_values.each do |attr, expected_value|
      specify "##{attr} returns #{expected_value}" do
        expect(vehicle.send attr).to eq(expected_value)
      end
    end

  end

end
