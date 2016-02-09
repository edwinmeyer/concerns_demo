class PersonWithAbilities < Person

  # PersonWithAbilities how one or more concerns (abilities) can be mixed into a class without requiring that
  # class to have any prior knowledge of the abilities being mixed in or of the initial mixin attribute values
  def initialize(f_name, l_name, abilities=[], attributes={})
    super(f_name, l_name)
    attributes[:wheelnum] ||= 0
    attributes[:max_passengers] ||= 1
    include_abilities(abilities, attributes)
  end

  protected
  def include_abilities(abilities, attributes)
    # An ability is any module which responds to is_ or has_ ability
    # puts "abilities before 'each': #{abilities}"
    abilities.each do |ability|
      # puts "ability before 'class << self': #{ability}"
      instance_eval(<<-STATEMENT)
      # Open the singleton class (eigenclass) of this specific object
      class << self
        # ability_module = Object.const_get("#{ability}".capitalize)
        # puts "ability inside 'class << self': #{ability}; classized: " + ability_module.to_s
        # dynamically include the module representing the ability into the singleton class
        include Object.const_get("#{ability}".capitalize)
      end
      # call the included ability's setup method with the attribute hash provided by the constructor
      # provide all constructor attributes and let the setup method use those it recognizes
      send("#{ability}_setup", attributes)
      STATEMENT
    end

  end
end
