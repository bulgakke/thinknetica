module ClassMethods
  attr_accessor :validations

  def validate(name, type, arg = "")
    self.validations ||= []
    rule = { type => { name: name, arg: arg } }
    validations << rule
  end
end

class Klass
  extend ClassMethods
  validate(:name, :presence)
end

k = Klass.new