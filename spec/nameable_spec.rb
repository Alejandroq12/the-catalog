require_relative '../nameable'

describe Nameable do
  context 'when correct_name is called on a Nameable instance' do
    nameable = Nameable.new

    it 'raises NotImplementedError' do
      expect { nameable.correct_name }.to raise_error(NotImplementedError)
    end
  end
end
