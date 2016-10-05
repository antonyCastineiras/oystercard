require 'station'

describe Station do

  subject {described_class.new("Victoria", 1)}

  describe 'initialize' do
    it 'knows what zone it is in' do
      expect(subject.zone).to be_an(Integer)
    end

    it 'knows what it\'s name is' do
      expect(subject.name).to be_a(String)
    end

  end
end
