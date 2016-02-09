# object_monkey_patch.rb

# Patch custom instance methods into Object
class Object

  def method_missing(method_name, *args)
    if method_name.to_s =~ /^(has|is)_\w+\?$/
      create_has_is_method(method_name)
      false
    else
      super
    end
  end

  protected

  def create_has_is_method(method_name)
    self.instance_eval(<<-METHOD_DEF)
      def #{method_name}
        # puts "generated #{method_name} called"
        false
      end
    METHOD_DEF
  end

end
