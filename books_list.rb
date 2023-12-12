require 'json'
require_relative 'book'

class BooksList
  DATA_FILE = 'books_data.json'.freeze

  def initialize(my_ui)
    @my_ui = my_ui
    @books = load_books
  end

  def list_all_books
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    puts
  end

  def find_book_by_index(index)
    @books[index] if index.between?(0, @books.length - 1)
  end

  def create_book
    title = @my_ui.input_prompt('Title: ')
    author = @my_ui.input_prompt('Author: ')

    @books << Book.new(title, author)
    # save_books
    puts 'Book created successfully'
    puts
  end

  def select_book
    puts 'Select a book from the following list by number'
    list_all_books
    book_index = @my_ui.gets_option.to_i
    @books[book_index]
  end

  def save_books
    File.write(DATA_FILE, JSON.pretty_generate(@books.map(&:to_hash)))
  end

  private

  def load_books
    return [] unless File.exist?(DATA_FILE)

    file_data = File.read(DATA_FILE)
    return [] if file_data.strip.empty?

    begin
      JSON.parse(file_data).map { |book_data| Book.new(book_data['title'], book_data['author']) }
    rescue JSON::ParserError => e
      puts "Error parsing JSON file: #{e.message}"
      []
    end
  end
end
