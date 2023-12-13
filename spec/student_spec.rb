require_relative '../student'
require_relative '../classroom'

describe Student do
  context 'when creating a new student' do
    student = Student.new(20, 'Alice', parent_permission: false)

    it 'has the correct name' do
      expect(student.name).to eq 'Alice'
    end

    it 'is a student' do
      expect(student).to be_a_kind_of(Student)
    end

    it 'can play hooky' do
      expect(student.play_hooky).to eq '¯\\_(ツ)_/¯'
    end
  end

  context 'when assigned to a classroom' do
    classroom = Classroom.new('Math')
    student = Student.new(20, 'Bob', classroom: classroom)

    it 'is assigned to the correct classroom' do
      expect(student.classroom).to eq classroom
    end

    it 'adds student to classroom students list' do
      expect(classroom.students).to include(student)
    end
  end

  context 'with no classroom assigned initially' do
    student = Student.new(20, 'Charlie')
    classroom = Classroom.new('Science')
    student.classroom = classroom

    it 'allows assigning a classroom later' do
      expect(student.classroom).to eq classroom
    end

    it 'updates classroom students list when assigned later' do
      expect(classroom.students).to include(student)
    end
  end
end
