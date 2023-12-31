require 'json'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'

class PeopleList
  DATA_FILE = 'people_data.json'.freeze

  def initialize(my_ui)
    @my_ui = my_ui
    @people = load_people
  end

  def list_all_people
    @people.each do |person|
      puts "Type: #{person.class}, Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts
  end

  def create_person
    choice = @my_ui.input_prompt('Do you want to create a student (1) or a teacher (2)? [input number]: ')

    case choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid option'
      return
    end
    puts 'Person created successfully'
    puts
  end

  def create_student
    age = nil
    loop do
      age = @my_ui.input_prompt('Age: ')
      break if age.match?(/^\d+$/) # checks if the input contains only digits

      puts 'Invalid age. Please enter a valid number.'
    end

    name = @my_ui.input_prompt('Name: ')

    parent_permission = nil
    loop do
      parent_permission = @my_ui.input_prompt('Has parent permission? [Y/N]: ').downcase
      break if %w[y n].include?(parent_permission)

      puts 'Invalid input. Please enter Y for Yes or N for No.'
    end

    @people << Student.new(age.to_i, name, parent_permission: parent_permission == 'y')
  end

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
  end

  def create_teacher
    age = nil
    loop do
      age = @my_ui.input_prompt('Age: ')
      break if age.match?(/^\d+$/) # checks if the input contains only digits

      puts 'Invalid age. Please enter a valid number.'
    end

    name = @my_ui.input_prompt('Name: ')
    name = 'Unknown' if name.empty?

    specialization = @my_ui.input_prompt('Specialization: ')

    @people << Teacher.new(age.to_i, name, specialization)
    # save_people
  end

  def select_person
    puts 'Select a person from the following list by number'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
    person_index = @my_ui.gets_option.to_i
    @people[person_index]
  end

  def save_people
    File.write(DATA_FILE, JSON.pretty_generate(@people.map(&:to_hash)))
  rescue StandardError => e
    puts "Failed to save data: #{e.message}"
  end

  private

  def load_people
    return [] unless File.exist?(DATA_FILE)

    file_data = File.read(DATA_FILE)
    return [] if file_data.strip.empty?

    begin
      JSON.parse(file_data).map do |person_data|
        case person_data['type']
        when 'Student'
          Student.from_hash(person_data)
        when 'Teacher'
          Teacher.from_hash(person_data)
        else
          Person.from_hash(person_data)
        end
      end
    rescue JSON::ParserError => e
      puts "Error parsing JSON file: #{e.message}"
      []
    end
  end
end
