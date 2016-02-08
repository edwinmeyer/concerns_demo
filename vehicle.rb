class Vehicle

  include ::Mobile

  def initialize(attributes={})
    mobile_setup attributes
  end
end
