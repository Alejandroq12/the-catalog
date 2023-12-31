require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'
require_relative 'console'
require_relative 'books_list'
require_relative 'rentals_list'
require_relative 'people_list'

class App
  def initialize
    puts "Welcome to School Library App!\n\n"
    @my_ui = Console.new
    @books_list = BooksList.new(@my_ui)
    @people_list = PeopleList.new(@my_ui)
    @rentals_list = RentalsList.new(@my_ui, @books_list, @people_list)
  end

  def list_all_books
    @books_list.list_all_books
  end

  def create_book
    @books_list.create_book
  end

  def list_rentals_for_person_id
    @rentals_list.list_rentals_for_person_id
  end

  def create_rental
    @rentals_list.create_rental
  end

  def create_person
    @people_list.create_person
  end

  def list_all_people
    @people_list.list_all_people
  end

  def save_all_data
    @books_list.save_books
    @people_list.save_people
    @rentals_list.save_rentals
  end
end
