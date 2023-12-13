require_relative '../classroom'
require_relative '../student'

describe Classroom do
  context 'when creating a new classroom' do
    classroom = Classroom.new('Biology')

    it 'has the correct label' do
      expect(classroom.label).to eq 'Biology'
    end

    it 'starts with no students' do
      expect(classroom.students).to be_empty
    end
  end

  context 'when adding students' do
    classroom = Classroom.new('Chemistry')
    student1 = Student.new(16, 'Alice')
    student2 = Student.new(17, 'Bob')

    before do
      classroom.add_student(student1)
      classroom.add_student(student2)
    end

    it 'contains students added to it' do
      expect(classroom.students).to include(student1, student2)
    end

    it 'sets the classroom for each student' do
      expect(student1.classroom).to eq classroom
      expect(student2.classroom).to eq classroom
    end
  end
end
