require 'journey'
require 'journey_log'




require 'journey_log'

describe JourneyLog do
	
	let(:journey) { double(:journey, entry_station: station) }
	let(:station) {  double(:station) }
	let(:journey_class) { double(:journey_class, new: journey) }

	describe '#initialize' do
		subject { described_class.new(journey) }  

		it 'asigns a journey object to the journey_class varaible' do
			expect(subject.journey_class).to eq(journey)
		end

		it 'asigns an empty array to journeys variable' do
			expect(subject.journeys).to eq []
		end

	end

	describe '#start' do
		subject { described_class.new(journey_class) }

		it 'starts a new journey with an entry_station' do
			allow(journey_class).to receive(:new).with(entry_station: station).and_return journey
			subject.start(station)
		end


	end

	describe '#finish' do
		subject { described_class.new(journey_class) }

		it 'adds an exit station to the current journey' do
			subject.start(station)
			subject.finish(station)
			expect(subject.current_journey.exit_station).to eq station
		end

		it 'records a journey' do
			allow(journey_class).to receive(:new).and_return journey
			subject.start(station)
			subject.finish(station)
			expect(subject.journeys).to include journey
		end

	end

end