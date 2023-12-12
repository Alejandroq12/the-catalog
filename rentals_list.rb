require_relative 'rental'

class RentalsList
  def initialize(my_ui, book_list, people_list)
    @my_ui = my_ui
    @book_list = book_list
    @people_list = people_list
    @rentals = []
  end

  def list_rentals_for_person_id
    id = @my_ui.input_prompt('ID of person: ').to_i

    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'

    rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      puts
    end
  end

  def create_rental
    book = @book_list.select_book
    person = @people_list.select_person
    date = @my_ui.input_prompt('Date: ')

    @rentals << Rental.new(date, book, person)
    puts 'Rental created successfully'
    puts
  end
end
