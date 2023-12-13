# spec/rental_spec.rb
require_relative '../rental'
require_relative '../book'
require_relative '../person'

describe Rental do
  let(:book) { Book.new('1984', 'George Orwell') }
  let(:person) { Person.new(30, 'John Doe') }
  let(:date) { '2020-01-01' }
  subject(:rental) { Rental.new(date, book, person) }

  context 'when a rental is created' do
    it 'has the correct date' do
      expect(rental.date).to eq(date)
    end

    it 'is linked to the correct book' do
      expect(rental.book).to eq(book)
      expect(book.rentals).to include(rental)
    end

    it 'is linked to the correct person' do
      expect(rental.person).to eq(person)
      expect(person.rentals).to include(rental)
    end
  end
end
