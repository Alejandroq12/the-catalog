# spec/decorator_spec.rb
require_relative '../decorator'
require_relative '../person'

describe Decorator do
  context 'when decorating a nameable object' do
    person = Person.new(25, 'Bob')
    decorated_person = Decorator.new(person)

    it 'delegates correct_name to the wrapped object' do
      expect(decorated_person.correct_name).to eq person.correct_name
    end
  end

  context 'when decorating an object without a correct_name method' do
    nameable = Class.new(Nameable).new
    decorated_nameable = Decorator.new(nameable)

    it 'raises NotImplementedError' do
      expect { decorated_nameable.correct_name }.to raise_error(NotImplementedError)
    end
  end
end
