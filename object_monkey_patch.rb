# object_monkey_patch.rb

class Object

  # def is_test?
  #   puts 'Object#is_test? called'
  #   false
  # end

  def method_missing(method_name, *args)
    # if self.class==ClassWithoutHasIs
    #   puts "Object#method_missing called for class #{self.class}"
    #   puts "method_name #{method_name}"
    # end
    if method_name.to_s =~ /^(has|is)_\w+\?$/
      # puts "method_name #{method_name} matches RE"
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
