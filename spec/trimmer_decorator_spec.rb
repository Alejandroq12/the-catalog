# spec/trimmer_decorator_spec.rb
require_relative '../trimmer_decorator'
require_relative '../person'

describe TrimmerDecorator do
  context 'when decorating a person with a short name' do
    person = Person.new(25, 'Alice')
    decorated_person = TrimmerDecorator.new(person)

    it 'does not trim a short name' do
      expect(decorated_person.correct_name).to eq 'Alice'
    end
  end

  context 'when decorating a person with a long name' do
    person = Person.new(30, 'Alexander Hamilton')
    decorated_person = TrimmerDecorator.new(person)

    it 'trims a long name to 10 characters' do
      expect(decorated_person.correct_name).to eq 'Alexander '
    end
  end
end
