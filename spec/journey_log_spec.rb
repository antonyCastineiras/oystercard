require 'journey'
require 'journey_log'




require 'journey_log'

describe JourneyLog do
	
	let(:journey) { double(:journey, :entry_station => nil, :exit_station => nil) }

	describe '#initialize' do

		it 'asigns a journey object to the journey_class varaible' do
			subject = described_class.new(journey)  
			expect(subject.journey_class).to eq(journey)
		end

	end

	describe '#start' do

		it 'starts a new journey with an entry_station' do
			subject = described_class.new(journey)
			expect(subject.start).to eq nil
		end

	end

end