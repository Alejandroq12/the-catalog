require_relative '../books_list'

RSpec.describe BooksList do
  let(:my_ui) { instance_double('Console') }
  let(:books_list) { BooksList.new(my_ui) }

  context 'when initialized' do
    it 'starts with an empty list of books' do
      allow(File).to receive(:exist?).and_return(false)
      expect(books_list.instance_variable_get(:@books)).to eq([])
    end
  end

  context 'when listing all books' do
    it 'prints each book with its index, title, and author' do
      book1 = Book.new('1984', 'George Orwell')
      book2 = Book.new('Brave New World', 'Aldous Huxley')
      books_list.instance_variable_set(:@books, [book1, book2])
      expected_output = "0) Title: \"1984\", Author: George Orwell\n" \
                        "1) Title: \"Brave New World\", Author: Aldous Huxley\n\n"
      expect { books_list.list_all_books }.to output(expected_output).to_stdout
    end
  end

  describe '#find_book_by_id' do
    it 'Returns the correct book when given a valid ID' do
      book1 = instance_double('Book', id: 1)
      book2 = instance_double('Book', id: 2)

      books_list.instance_variable_set(:@books, [book1, book2])

      expect(books_list.find_book_by_id(2)).to eq(book2)
    end

    it 'Returns nil when given an invalid ID' do
      book1 = instance_double('Book', id: 1)
      book2 = instance_double('Book', id: 2)

      books_list.instance_variable_set(:@books, [book1, book2])

      expect(books_list.find_book_by_id(3)).to be_nil
    end
  end

  describe '#create_book' do
    it 'Creates a new book and adds it to the list' do
      allow(my_ui).to receive(:input_prompt).with('Title: ').and_return('New Book')
      allow(my_ui).to receive(:input_prompt).with('Author: ').and_return('New Author')

      books_list.create_book

      new_book = books_list.instance_variable_get(:@books).last

      expect(new_book.title).to eq('New Book')
      expect(new_book.author).to eq('New Author')
    end
  end

  describe '#select_book' do
    it 'Returns the selected book' do
      book1 = instance_double('Book', title: 'Book 1', author: 'Author 1')
      book2 = instance_double('Book', title: 'Book 2', author: 'Author 2')

      allow(books_list).to receive(:list_all_books)
      allow(my_ui).to receive(:gets_option).and_return('0')
      books_list.instance_variable_set(:@books, [book1, book2])
      selected_book = books_list.select_book
      expect(selected_book.title).to eq('Book 1')
      expect(selected_book.author).to eq('Author 1')
    end
  end

  context 'when saving books' do
    it 'Writes to the book to the data file' do
      book = Book.new('Sample Title', 'Sample Author')
      books_list.instance_variable_set(:@books, [book])
      expected_json = JSON.pretty_generate([book.to_hash])
      expect(File).to receive(:write).with(BooksList::DATA_FILE, expected_json)
      books_list.save_books
    end
  end
end
