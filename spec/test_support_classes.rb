# test_support_classes.rb

class ClassWithoutHasIs
  # This empty class has no "has_*?" or "is_*?" methods
end

class ClassWithHasIs
  def has_test?; true; end
  def is_test?; true; end
end

class ClassWithMobileAbility
  include ::Mobile

  def initialize(attributes={})
    mobile_setup(attributes)
  end
end

class ElectricClassWithMobileAbility < ClassWithMobileAbility; end

class ClassWithWeaponsAbility
  include ::Weapons

  def initialize(attributes={})
    weapons_setup(attributes)
  end
end



class ClassWithMobileWeaponsAbility
  include ::Mobile
  include ::Weapons

  def initialize(attributes={})
    mobile_setup(attributes)
    weapons_setup(attributes)
  end
end
