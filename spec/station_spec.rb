require 'station'

describe Station do

	describe '#initialize' do

		it 'sets a zone variable' do
			subject = described_class.new("station",1)
			expect(subject.zone).to eq 1 
		end

		it 'sets a name for the station' do
			subject = described_class.new("station")
			expect(subject.name).to eq "station"
		end

	end
end