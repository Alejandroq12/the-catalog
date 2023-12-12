require_relative 'classroom_manager'

class Student < Person
  attr_reader :classroom

  def initialize(age, name = 'Unknown', parent_permission: true, classroom: nil)
    super(age, name, parent_permission: parent_permission)
    @classroom = ClassroomManager.next_classroom
    classroom.add_student(self) unless classroom.nil? || classroom.students.include?(self)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\\_(ツ)_/¯'
  end

  def to_hash
    super.merge({ 'classroom' => @classroom })
  end

  def self.from_hash(hash)
    new(hash['age'], hash['name'], parent_permission: hash['parent_permission'], classroom: hash['classroom'])
  end
end
