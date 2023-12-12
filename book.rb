class Book
  @last_id = 0

  class << self
    attr_accessor :last_id

    def next_id
      @last_id += 1
    end
  end

  attr_accessor :title, :author, :rentals, :id

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    @id = self.class.next_id
  end

  def add_rental(person, date)
    Rental.new(date, self, person)
  end

  def to_hash
    { 'id' => @id, 'title' => @title, 'author' => @author }
  end
end
