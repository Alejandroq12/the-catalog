require_relative 'person'

class Teacher < Person
  def initialize(age, name, specialization, parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_hash
    super.merge({ 'specialization' => @specialization })
  end

  def self.from_hash(hash)
    new(hash['age'], hash['name'], hash['specialization'], parent_permission: hash['parent_permission'])
  end
end
