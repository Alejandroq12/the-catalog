class Console
  def show_console
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def input_prompt(message)
    print message
    gets.chomp
  end

  def gets_option
    gets.chomp
  end
end
