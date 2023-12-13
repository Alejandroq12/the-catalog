# spec/teacher_spec.rb
require_relative '../teacher'

describe Teacher do
  context 'when creating a new teacher' do
    teacher = Teacher.new(35, 'Mr. Smith', 'Mathematics')

    it 'has the correct name' do
      expect(teacher.name).to eq 'Mr. Smith'
    end

    it 'has the correct age' do
      expect(teacher.age).to eq 35
    end

    it 'has the correct specialization' do
      expect(teacher.instance_variable_get(:@specialization)).to eq 'Mathematics'
    end

    it 'can always use services' do
      expect(teacher.can_use_services?).to be true
    end
  end

  context 'when created from a hash' do
    hash = {'age' => 40, 'name' => 'Mrs. Johnson', 'specialization' => 'History'}
    teacher = Teacher.from_hash(hash)

    it 'has the correct attributes from hash' do
      expect(teacher.name).to eq 'Mrs. Johnson'
      expect(teacher.age).to eq 40
      expect(teacher.instance_variable_get(:@specialization)).to eq 'History'
    end
  end
end
