# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*attributes)
    history_of_values = {}

    attributes.each do |attribute|
      var_name = "@#{attribute}".to_sym

      define_method(attribute) { instance_variable_get(var_name) }

      define_method("#{attribute}=") do |value|
        var_history = history_of_values[:attribute] || []
        history_of_values.merge!(attribute: var_history)
        instance_variable_set(var_name, value)
        current_value = instance_variable_get(var_name)
        var_history << current_value
      end

      define_method("#{attribute}_history") { history_of_values[:attribute] }
    end
  end

  def strong_attr_accessor(attributes_classes = {})
    attributes_classes.each_pair do |attribute, attr_class|
      attr_name = "@#{attribute}".to_sym
      attr_class = attr_class
      define_method(attribute) { instance_variable_get(attr_name) }
      define_method("#{attribute}=") do |value|
        raise "Wrong class, #{value} isn't an instance of #{attr_class}" unless value.class == attr_class

        instance_variable_set(attr_name, value)
      end
    end
  end
end
# class TestClass
#   include Accessors
#   strong_attr_accessor name: Symbol, length: Integer, previous_names: Array
#   attr_accessor_with_history :randomvalue
# end
#
# test = TestClass.new
# test.name = :a123
# test.length = 123
# test.previous_names = [1, 2, 3] # => no exceptions
# test.randomvalue = 70
# test.randomvalue = 123
# test.randomvalue = 333
# test.randomvalue = 0
# test.randomvalue = 'абдырвалг'
# test.randomvalue = { a1: 2 }
# test.randomvalue = '123s'
#
# puts test.randomvalue_history
# => 70
# => 123
# => 333
# => 0
# => абдырвалг
# => {:a1=>2}
# => 123s
#
# Вроде и работает как надо, но очень уж грязно написано, мне не нравится (особенно _with_history).
# И так пытался, и эдак - получилось только как получилось.
