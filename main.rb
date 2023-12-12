require_relative 'app'
require_relative 'console'

app = App.new
console1 = Console.new
loop do
  console1.show_console
  choice = console1.gets_option

  case choice
  when '1'
    app.list_all_books
  when '2'
    app.list_all_people
  when '3'
    app.create_person
  when '4'
    app.create_book
  when '5'
    app.create_rental
  when '6'
    app.list_rentals_for_person_id
  when '7'
    puts 'Thank you for using this app!'
    exit
  else
    puts 'Invalid option'
  end
end
