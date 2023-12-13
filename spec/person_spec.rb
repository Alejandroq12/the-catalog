# spec/person_spec.rb
require_relative '../person'

describe Person do
  context 'when creating a new person' do
    person = Person.new(22, 'John Doe')

    it 'has the correct name' do
      expect(person.name).to eq 'John Doe'
    end

    it 'has the correct age' do
      expect(person.age).to eq 22
    end

    it 'has a unique id' do
      expect(person.id).not_to be_nil
    end

    it 'can use services' do
      expect(person.can_use_services?).to be true
    end
  end

  context 'with parent permission' do
    person = Person.new(15, 'Jane Doe', parent_permission: true)

    it 'can use services with parent permission' do
      expect(person.can_use_services?).to be true
    end
  end

  context 'without parent permission' do
    person = Person.new(15, 'Jane Doe', parent_permission: false)

    it 'cannot use services without parent permission' do
      expect(person.can_use_services?).to be false
    end
  end

  context 'when adding a rental' do
    person = Person.new(22, 'John Doe')
    before do
      @rental = double('rental')
      person.add_rental(@rental)
    end

    it 'contains the rental in rentals array' do
      expect(person.rentals).to include(@rental)
    end
  end
end
