require_relative 'book'

class BooksList
  def initialize(my_ui)
    @my_ui = my_ui
    @books = []
  end

  def list_all_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    puts
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created successfully'
    puts
  end

  def select_book
    @interface.print_message('Select a book from the following list by number')
    @books.each_with_index do |book, index|
      @interface.print_message("#{index}) Title: \"#{book.title}\", Author: #{book.author}")
    end
    book_index = @interface.input.to_i
    @books[book_index]
  end
end
