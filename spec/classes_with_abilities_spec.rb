# classes_with_abilities_spec.rb

require_relative '../weapons'

describe "A class having Mobile ability" do

  [ {method_name: :is_mobile?, expected_value: true},
    {method_name: :has_weapons?, expected_value: false},
    {method_name: :is_random?, expected_value: false}
  ].each do |m_data|
      it "##{m_data[:method_name]} returns #{m_data[:expected_value]}" do
        perform_test(test_class=ClassWithMobileAbility, m_data[:method_name], m_data[:expected_value])
      end
  end

end

[true, false].each do |is_e_class|
  describe "A#{is_e_class ? 'n ' : ' Non-'}Electric class" do
    specify "#is_electric? returns #{is_e_class}" do
      obj = (is_e_class ? ElectricClassWithMobileAbility : ClassWithMobileAbility).new
      expect(obj.is_electric?).to (is_e_class ? be_truthy : be_falsy)
    end
  end
end


MAX_AMMO_SPECIFIED = 2

describe "A class having Weapons ability" do
  [ {method_name: :has_weapons?, expected_value: true},
    {method_name: :is_mobile?, expected_value: false},
    {method_name: :is_random?, expected_value: false}
  ].each do |m_data|
    it "##{m_data[:method_name]} returns #{m_data[:expected_value]}" do
      perform_test(test_class=ClassWithWeaponsAbility, m_data[:method_name], m_data[:expected_value])
    end
  end
end

[true, false].each do |use_default_values|
  describe "A class having Weapons ability#{use_default_values ? ' that uses default "max_ammo" value' : ''}" do
    specify "initially remaining_ammo == max_ammo" do
       if use_default_values
        expected_ammo = ClassWithWeaponsAbility::MAX_AMMO_DEFAULT
        obj = ClassWithWeaponsAbility.new
      else
        expected_ammo = MAX_AMMO_SPECIFIED
        obj = ClassWithWeaponsAbility.new(max_ammo: expected_ammo)
      end

      # obj = use_default_values : ClassWithWeaponsAbility.new
      expect(obj.max_ammo).to eq(expected_ammo)
      expect(obj.remaining_ammo).to eq(expected_ammo)
    end
  end
end

describe "A class having Weapons ability" do
  let (:obj) {ClassWithWeaponsAbility.new(max_ammo: MAX_AMMO_SPECIFIED)}

  specify "#shoot! expends a single round when ammo remains" do
    expect(obj.shoot!).to eq(true)
    expect(obj.remaining_ammo).to eq(MAX_AMMO_SPECIFIED - 1)
  end

  specify "#shoot! fails when no ammo remains" do
    MAX_AMMO_SPECIFIED.times {expect(obj.shoot!).to eq(true)}
    expect(obj.shoot!).to eq(false)
    expect(obj.remaining_ammo).to eq(0)
  end

  specify "#reload! restores 'max_ammo' shells" do
    (MAX_AMMO_SPECIFIED-1).times {expect(obj.shoot!).to eq(true)}
    obj.reload!
    expect(obj.remaining_ammo).to eq(MAX_AMMO_SPECIFIED)
  end

end

describe "A class having both Mobile and Weapons ability" do

  [ {method_name: :is_mobile?, expected_value: true},
    {method_name: :has_weapons?, expected_value: true},
    {method_name: :is_random?, expected_value: false}
  ].each do |m_data|
      it "##{m_data[:method_name]} returns #{m_data[:expected_value]}" do
        perform_test(test_class=ClassWithMobileWeaponsAbility, m_data[:method_name], m_data[:expected_value])
      end
  end

end

def perform_test(test_class, method_name, expected)
  obj = test_class.new # A real class is required -- a mock will always return false
  expect(obj.send method_name).to eq(expected)
  expect(obj).to receive(method_name).once
  obj.send method_name
end
