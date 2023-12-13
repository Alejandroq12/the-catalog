require_relative '../rentals_list'
require_relative '../rental'
require_relative '../book'
require_relative '../person'

describe RentalsList do
  let(:mock_ui) { double('Console') }
  let(:mock_book_list) { double('BooksList') }
  let(:mock_people_list) { double('PeopleList') }
  subject(:rentals_list) { RentalsList.new(mock_ui, mock_book_list, mock_people_list) }

  before do
    allow(mock_book_list).to receive(:find_book_by_id).and_return(Book.new('Sample Book', 'Sample Author'))
    allow(mock_people_list).to receive(:find_person_by_id).and_return(Person.new(25, 'Jane Doe'))
  end

  context 'when creating a rental' do
    let(:book) { Book.new('1984', 'George Orwell') }
    let(:person) { Person.new(30, 'John Doe') }
    let(:date) { '2021-01-01' }

    before do
      allow(mock_book_list).to receive(:select_book).and_return(book)
      allow(mock_people_list).to receive(:select_person).and_return(person)
      allow(mock_ui).to receive(:input_prompt).with('Date: ').and_return(date)

      rentals_list.create_rental
    end

    it 'adds a new rental to the rentals list' do
      expect(rentals_list.instance_variable_get(:@rentals).last.date).to eq(date)
      expect(rentals_list.instance_variable_get(:@rentals).last.book).to eq(book)
      expect(rentals_list.instance_variable_get(:@rentals).last.person).to eq(person)
    end
  end

  context 'when listing rentals for a specific person id' do
    it 'prints rentals for that person' do
      book = Book.new('Brave New World', 'Aldous Huxley')
      person = Person.new(28, 'Alice Smith')
      rental = Rental.new('2021-05-20', book, person)
      rentals_list.instance_variable_set(:@rentals, [rental])
      allow(mock_ui).to receive(:input_prompt).with('ID of person: ').and_return(person.id.to_s)

      expected_output = "Rentals:\nDate: 2021-05-20, Book \"Brave New World\" by Aldous Huxley\n\n"
      expect { rentals_list.list_rentals_for_person_id }.to output(expected_output).to_stdout
    end
  end

  context 'when saving rentals' do
    it 'writes to the data file' do
      book = Book.new('Sample Book', 'Sample Author')
      person = Person.new(25, 'Jane Doe')
      rental = Rental.new('2021-06-01', book, person)
      rentals_list.instance_variable_set(:@rentals, [rental])
      expected_json = JSON.pretty_generate([rental.to_hash])

      expect(File).to receive(:write).with(RentalsList::DATA_FILE, expected_json)
      rentals_list.save_rentals
    end
  end
end
