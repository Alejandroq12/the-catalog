require_relative '../book'
require_relative '../rental'
require_relative '../person'

RSpec.describe Book do
  describe '#initialize' do
    it 'Assigns a unique ID to each book' do
      book1 = Book.new('Title 1', 'Author 1')
      book2 = Book.new('Title 2', 'Author 2')
      expect(book1.id).not_to eq(book2.id)
    end

    it 'Increments the Book last_id' do
      book1 = Book.new('Title 1', 'Author 1')
      book2 = Book.new('Title 2', 'Author 2')
      expect(book2.id).to eq(book1.id + 1)
    end
  end

  describe '#add_rental' do
    it 'Creates a new rental for the book' do
      book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
      person = Person.new(20, 'John Doe')
      date = '2023-12-12'
      rental = book.add_rental(person, date)
      expect(rental).to be_an_instance_of(Rental)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(rental.date).to eq(date)
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end
end
