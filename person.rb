class Person
  include Celluloid
  attr_accessor :age
  def initialize age
    @age = age
  end
end
