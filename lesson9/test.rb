# frozen_string_literal: true

module Validation
  def validate(*types)
    types.each do |type|
      define_method("validate_#{type}") do |var, parameter = nil|
        var = instance_variable_get("@#{var}")

        if type == :presense
          raise "#{var} can't be empty" if var.nil? || var.to_s.strip == ''
        elsif type == :format
          raise 'Use Regexp as a parameter' unless parameter.class == Regexp
          # структурно строчка выше вроде не здесь должна быть, но понятия не имею, куда её деть
          # тут должны быть исключения для юзера (как ниже), а куда класть исключения для кодера?
          raise "Wrong number format for #{var}, should fit #{parameter}" if var !~ parameter
        elsif type == :class
          raise 'Use proper Class name as a parameter' unless parameter.class == Class
          raise "Wrong #{var} class, should be #{parameter}" unless var.class == parameter
        else
          raise "Wrong arguments for 'validate', should be [:presense/:format/:type]"
        end
        print 'SUCCESS ' # debug
      end
    end
  end
end

class Test
  extend Validation
  attr_accessor :number
  validate :class, :presense, :format
  FORMAT = /^[a-zа-я\d]{3}(-[a-zа-я\d]{2})?$/.freeze
  /^[A-ZА-Я]{1}[a-zа-я]{1+}$/

  def validate_all(var)
    validate_class(var, String)
    validate_presense(var)
    validate_format(var, FORMAT)
  end
end

t = Test.new
t.number = '123'
t.validate_all(:number) # => SUCCESS SUCCESS SUCCESS
