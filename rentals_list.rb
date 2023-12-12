require_relative 'rental'

class RentalsList
  DATA_FILE = 'rentals_data.json'.freeze

  def initialize(my_ui, book_list, people_list)
    @my_ui = my_ui
    @book_list = book_list
    @people_list = people_list
    @rentals = load_rentals
  end

  def list_rentals_for_person_id
    id = @my_ui.input_prompt('ID of person: ').to_i

    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'

    rentals.each do |rental|
      book = @book_list.find_book_by_index(rental.book_index)
      puts "Date: #{rental.date}, Book \"#{book.title}\" by #{book.author}"
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
    save_rentals
  end

  def save_rentals
    File.write(DATA_FILE, JSON.pretty_generate(@rentals.map(&:to_hash)))
  rescue StandardError => e
    puts "Failed to save data: #{e.message}"
  end

  private

  def load_rentals
    return [] unless File.exist?(DATA_FILE)

    file_data = File.read(DATA_FILE)
    return [] if file_data.strip.empty?

    JSON.parse(file_data).map do |rental_data|
      book_index = rental_data['book_id'].to_i
      book = @book_list.find_book_by_index(book_index)
      person = @people_list.find_person_by_id(rental_data['person_id'])
      Rental.new(rental_data['date'], book, person) if book && person
    end.compact
  rescue JSON::ParserError => e
    puts "Error parsing JSON file: #{e.message}"
    []
  end
end
