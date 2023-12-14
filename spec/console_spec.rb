require_relative '../console'

RSpec.describe Console do
  describe '#show_console' do
    it 'Displays the console options' do
      console = Console.new
      expected_output = <<~MENU
        Please choose an option by entering a number:
        1 - List all books
        2 - List all people
        3 - Create a person
        4 - Create a book
        5 - Create a rental
        6 - List all rentals for a given person id
        7 - Exit
      MENU
      expect { console.show_console }.to output(expected_output).to_stdout
    end
  end

  describe '#input_prompt' do
    it 'Prompts the user and returns input' do
      console = Console.new
      allow(console).to receive(:gets).and_return('user_input')
      expect(console.input_prompt('Enter something: ')).to eq('user_input')
    end
  end

  describe '#gets_option' do
    it 'Reads the user input for the menu options' do
      console = Console.new
      allow(console).to receive(:gets).and_return('3')
      expect(console.gets_option).to eq('3')
    end
  end
end
