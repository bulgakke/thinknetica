# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    

    def validators 
      @validators
    end

    def validators_add(validator)
      @validators ||= []
      @validators << validator 
    end

    def validate(var, type, parameter = nil)
      validator = { variable_to_validate: var, type_of_validation: type, validation_parameter: parameter }
      # каким образом делать это переменной экземпляра, если validate - это метод класса? И параметры валидации общие для всех объектов класса?
      # В какую переменную экземпляра он будет складывать параметры? В initialize что-то писать?
      validators_add(validator)     
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validators.each do |validator|
        var_name = validator[:variable_to_validate]
        var = instance_variable_get("@#{var_name}")
        type = validator[:type_of_validation]
        parameter = validator[:validation_parameter]
        send("validate_#{type}", var, parameter)
=begin
        case type
        when :presence
          validate_presence(var)
        when :format
          validate_format(var, parameter)
        when :class
          validate_class(var, parameter)
        when :equals
          validate_equals(var, parameter)
        when :characters
          validate_characters(var, parameter)
        else
          raise "Wrong 'type' argument for 'validate', should be :presence/:format/:class/:equals/:characters"
        end
=end
      end
    end

    def validate_presence(var, parameter=nil)
      raise "#{var} can't be empty" if var.nil? || var.to_s.strip == ''
    end

    def validate_format(var, parameter)      
      raise 'Use Regexp as a parameter' unless parameter.class == Regexp
      raise "Wrong number format for #{var}, should fit #{parameter}" if var !~ parameter
    end

    def validate_class(var, parameter)
      unless (parameter.class == Class) || (parameter[0] == Class)
        raise 'Use a proper Class (or an array of them) as a parameter'
      end

      unless var.class == parameter || (parameter.class == Array && parameter.include?(var.class))
        raise "Wrong #{var} class, should be #{parameter}"
      end
    end

    def validate_equals(var, parameter)
      raise "#{var} should be equal to #{parameter}" unless var == parameter || parameter.include?(var)
    end

    def validate_characters(var, parameter)
      raise "You can only use Latin and Cyrillic, numbers, spaces, '-' and '_'." if invalid_chars?(var)
    end

    protected
    
    def invalid_chars?(string)
      allowed = ('A'..'Z').to_a + ('a'..'z').to_a + ('А'..'Я').to_a + ('а'..'я').to_a + ('0'..'9').to_a + ['-', '_', ' ']
      string.chars.each do |character|
        return true if allowed.include?(character) == false
      end
      false
    end
  end
end

class TestClass
  include Validation
  attr_accessor :name, :weight, :length
  validate :name, :format, /^[A-ZА-Я]{1}[a-zа-я]+$/
  validate :weight, :class, Integer
  validate :length, :presence
end

t = TestClass.new
t.name = 'Qwe'
t.weight = 123
t.length = ' '
t.validate!
