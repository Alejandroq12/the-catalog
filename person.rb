require_relative 'nameable'
require_relative 'id_manager'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = IDManager.next_id
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def to_hash
    {
      'type' => self.class.to_s,
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission
    }
  end

  def self.from_hash(hash)
    new(hash['age'], hash['name'], parent_permission: hash['parent_permission'])
  end

  private

  def of_age?
    @age >= 18
  end
end
