require_relative 'rental'

class RentalsList
  def initialize(my_ui, book_list)
    @my_ui = my_ui
    @book_list = book_list
    @rentals = []
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = gets.chomp.to_i

    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'

    rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      puts
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'

    # @books.each_with_index do |book, index|
    #   puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    # end
    book = @book_list.select_book

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}]: Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    @rentals << Rental.new(date, book, @people[person_index])
    puts 'Rental created successfully'
    puts
  end
end
