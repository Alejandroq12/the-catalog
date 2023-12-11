require_relative 'rental'

class RentalsList
  def initialize(my_ui, book_list, people_list)
    @my_ui = my_ui
    @book_list = book_list
    @people_list = people_list
    @rentals = []
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = @my_ui.gets_option.to_i

    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'

    rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      puts
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'

    book = @book_list.select_book
    person = @people_list.select_person
    print 'Date: '
    date = gets.chomp

    @rentals << Rental.new(date, book, person)
    puts 'Rental created successfully'
    puts
  end
end
