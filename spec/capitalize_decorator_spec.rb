require_relative '../capitalize_decorator'
require_relative '../person'

describe CapitalizeDecorator do
  context 'when decorating a nameable object with a lowercase name' do
    let(:lowercase_name_person) { instance_double('Person', correct_name: 'john doe') }
    subject(:decorated_person) { CapitalizeDecorator.new(lowercase_name_person) }

    it 'capitalizes the first letter of the name' do
      expect(decorated_person.correct_name).to eq 'John doe'
    end
  end

  context 'when decorating a nameable object with an uppercase name' do
    let(:uppercase_name_person) { instance_double('Person', correct_name: 'JOHN DOE') }
    subject(:decorated_person) { CapitalizeDecorator.new(uppercase_name_person) }

    it 'capitalizes only the first letter of the name' do
      expect(decorated_person.correct_name).to eq 'John doe'
    end
  end

  context 'when decorating a nameable object with a mixed case name' do
    let(:mixed_case_name_person) { instance_double('Person', correct_name: 'jOhN dOe') }
    subject(:decorated_person) { CapitalizeDecorator.new(mixed_case_name_person) }

    it 'capitalizes only the first letter of the name' do
      expect(decorated_person.correct_name).to eq 'John doe'
    end
  end
end
