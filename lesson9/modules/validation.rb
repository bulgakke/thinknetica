# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    
  end

  module InstanceMethods
    def validate!(value, validations={}) # уже на этом месте запутался, как лучше эти параметры вводить
      var = instance_variable_get(value)
      validations.each_pair do |validation, parameter|
        if validation == :presence
          raise "#{var} can't be empty" if var == nil || var.to_s.strip == ''
        elsif validation == :format
          raise "Use Regexp as a parameter" unless parameter.class == Regexp 
          # структурно строчка выше вроде не здесь должна быть, но понятия не имею, куда её деть
          raise "Wrong number format for #{var}, should fit #{parameter}" if var !~ parameter
        elsif validation == :type
          raise "Use proper Class name as a parameter" unless parameter.class == Class
          # аналогично 
          raise "Wrong #{var} type, should be #{parameter}" if var.class != parameter
        else
          raise "Wrong arguments for 'validate'"
        end
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end

class TestClass
  include Validation
  attr_accessor :name, :weight, :length
end

t = TestClass.new
t.name = 'Qwe'
t.validate!(@name, type: String)

# Traceback (most recent call last):
# 2: from validation.rb:49:in `<main>'
# 1: from validation.rb:15:in `validate!'
# validation.rb:15:in `instance_variable_get': nil is not a symbol nor a string (TypeError)