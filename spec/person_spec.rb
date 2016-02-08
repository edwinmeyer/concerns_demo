# person_spec.rb

require_relative '../person'
require_relative '../person_with_abilities'

[ {klass: Person, fname: 'Homer', lname: 'Simpson'},
  {klass: PersonWithAbilities, fname: 'Unarmed', lname: 'Immobile'},
  {klass: PersonWithAbilities, fname: 'Unarmed', lname: 'Mobile', abilities: [:mobile], attributes: {wheelnum: 5} },
  {klass: PersonWithAbilities, fname: 'Armed', lname: 'Immobile', abilities: [:weapons], attributes: {wheelnum: 5, max_ammo: 6} },
  {klass: PersonWithAbilities, fname: 'Armed', lname: 'Mobile', abilities: [:mobile, :weapons], attributes: {wheelnum: 5, max_ammo: 6} }
].each do |k_data|

  describe k_data[:klass] do
    arg_list_for_new = [k_data[:fname], k_data[:lname]]
    if k_data[:klass] == PersonWithAbilities
      arg_list_for_new <<  k_data[:abilities] if k_data[:abilities]
      arg_list_for_new <<  k_data[:attributes] if k_data[:attributes]
    end
    let(:person) { k_data[:klass].new(*arg_list_for_new) }
    it "#{k_data[:fname]} #{k_data[:lname]} has a first and last name" do
      # puts "person = #{person.inspect}"
      expect(person.first_name).to eq(k_data[:fname])
      expect(person.last_name).to eq(k_data[:lname])
      if k_data[:abilities]
        # mobile expectations
        if k_data[:abilities].include? :mobile
          expected_wheelnum = (k_data[:attributes] && k_data[:attributes].include?(:wheelnum)) ? k_data[:attributes][:wheelnum] : 0
          expect(person.wheelnum).to eq(expected_wheelnum)
        end
        # weapons expectations
        if k_data[:abilities].include? :weapons
          expected_max_ammo = (k_data[:attributes] && k_data[:attributes].include?(:max_ammo)) ? k_data[:attributes][:max_ammo] : 6
          expect(person.max_ammo).to eq(expected_max_ammo)

        end
      end



    end

    # This is true of all instances where these attributes are not explicitly defined
    [:is_electric?, :is_mobile?, :has_weapons?].each do |bin_attr|
      ability = bin_attr[/.*_(\w+)\?/, 1] # get the 1st matched group
      # puts "related ability for #{bin_attr}: #{ability}"
      expected_truth_value = k_data[:abilities] && k_data[:abilities].include?(ability.to_sym) || false

      it "##{bin_attr} returns #{expected_truth_value}" do
        expect(person.send(bin_attr)).to (expected_truth_value ? be_truthy : be_falsy)
      end
    end
  end

end
