require_relative 'book'

class BooksList
  def initialize(my_ui)
    @my_ui = my_ui
    @books = []
  end

  def list_all_books
    read = read_books_file
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    puts
  end

  def create_book
    title = @my_ui.input_prompt('Title: ')
    author = @my_ui.input_prompt('Author: ')

    @books << Book.new(title, author)
    puts 'Book created successfully'
    puts
  end

  def select_book
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = @my_ui.gets_option.to_i
    @books[book_index]
  end

  def read_book_files
    [] unless File.exist?('books_data.json')
    file_data1 = File.read('books_data.json').split
    file_data_parsed = JSON.parse(file_data1)
    @books = file_data_parsed
  end
end
