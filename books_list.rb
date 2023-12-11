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
end
