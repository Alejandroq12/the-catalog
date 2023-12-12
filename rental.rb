class Rental
  attr_accessor :date, :book_index, :person_id

  def initialize(date, book, person)
    @date = date
    self.book = book
    self.person = person
    @book_index = book.index
    @person_id = person.id
  end

  def book=(book)
    @book = book
    book.rentals << self unless book.rentals.include?(self)
  end

  def person=(person)
    @person = person
    person.rentals << self unless person.rentals.include?(self)
  end

  def to_hash
    {
      'date' => @date,
      'book_id' => @book_index,
      'person_id' => @person_id
    }
  end
end
