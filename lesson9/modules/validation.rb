# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@validators ||= []
    def validate(var, type, parameter = nil)
      validator = { variable_to_validate: var, type_of_validation: type, validation_parameter: parameter }
      @@validators << validator

      define_method('validate!') do
        @@validators.each do |validator|
          var_name = validator[:variable_to_validate]
          var = instance_variable_get("@#{var_name}")
          type = validator[:type_of_validation]
          parameter = validator[:validation_parameter]

          if type == :presence
            raise "#{var} can't be empty" if var.nil? || var.to_s.strip == ''
          elsif type == :format
            raise 'Use Regexp as a parameter' unless parameter.class == Regexp
            # структурно строчка выше вроде не здесь должна быть, но понятия не имею, куда её деть
            # тут должны быть исключения для юзера (как ниже), а куда класть исключения для кодера?
            raise "Wrong number format for #{var}, should fit #{parameter}" if var !~ parameter
          elsif type == :class
            unless (parameter.class == Class) || (parameter[0] == Class)
              raise 'Use a proper Class (or an array of them) as a parameter'
            end
            raise "Wrong #{var} class, should be #{parameter}" unless var.class == parameter || parameter.include?(var)
          elsif type == :equals
            raise "#{var} should be equal to #{parameter}" unless var == parameter || parameter.include?(var)
          elsif type == :characters
            raise "You can only use Latin and Cyrillic, numbers, spaces, '-' and '_'." if invalid_chars?(var) == true
          else
            raise "Wrong 'type' argument for 'validate', should be :presence/:format/:class"
          end
        end
      end
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def invalid_chars?(string)
      allowed = ('A'..'Z').to_a + ('a'..'z').to_a + ('А'..'Я').to_a + ('а'..'я').to_a + ('0'..'9').to_a + ['-', '_', ' ']
      # ничего, что я в таких случаях return пишу?
      # и самому понятнее, что происходит, и вообще на всякий случай
      string.chars.each do |character|
        return true if allowed.include?(character) == false
      end
      false
    end
  end
end
# class TestClass
#   include Validation
#   attr_accessor :name, :weight, :length
#   validate :name, :format, /^[A-ZА-Я]{1}[a-zа-я]+$/
#   validate :weight, :class, Integer
#   validate :length, :presence
# end
#
# t = TestClass.new
# t.name = 'Qwe'
# t.weight = 123
# t.length = ''
# puts t.valid? # => true/false
