require 'test_support_classes'
require_relative '../object_monkey_patch.rb'

describe "binary attributes" do

  [:has_test?, :is_test?].each do |method_name|

    describe "An object which does not define #{method_name}" do
      it "returns false when #{method_name} is called" do
        perform_test(test_class=ClassWithoutHasIs, method_name, expected=false)
        # obj = ClassWithoutHasIs.new # A real class is required -- a mock will always return false
        # expect(obj.send method_name).to eq(false)
        # expect(obj).to receive(:method_missing).never # dynamically defining the method on the class instance suppresses this
        # expect(obj).to receive(method_name).twice
        # obj.send method_name # A has_*? or is_*? instance method is created
        # obj.send method_name # The dynamically-created instance method is used
      end
    end

    describe "An object which defines #{method_name}" do
      it "returns true when #{method_name} is called" do
        perform_test(test_class=ClassWithHasIs, method_name, expected=true)
      #   obj = ClassWithHasIs.new # A real class is required -- a mock will always return false
      #   expect(obj.send method_name).to eq(true)
      #   expect(obj).to receive(:method_missing).never # dynamically defining the method on the class instance suppresses this
      #   expect(obj).to receive(method_name).twice
      #   obj.send method_name # A has_*? or is_*? instance method is created
      #   obj.send method_name # The dynamically-created instance method is used
      # end
      end
    end
   end

end

# This test is necessarily inadequate because dynamically defining the has/is? method on the object apparently
# prevents rspec from recognizing that :method_missing has been called, which makes it impossible to
# to distinguish the value returned by method_missing and that returned by the generated instance method.
def perform_test(test_class, method_name, expected)
  obj = test_class.new # A real class is required -- a mock will always return false
  expect(obj.send method_name).to eq(expected)
  expect(obj).to receive(:method_missing).never # dynamically defining the method on the class instance suppresses this
  expect(obj).to receive(method_name).twice
  obj.send method_name # A has_*? or is_*? instance method is created
  obj.send method_name # The dynamically-created instance method is used
end
