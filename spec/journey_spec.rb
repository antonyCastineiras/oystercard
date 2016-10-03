require 'journey'
require 'station'
require 'oyster_card'

describe Journey do

	let(:station) { double(:station, :zone => 1) }
	let(:exit_station) { double(:station, :zone => 2)}

	describe '#initialize' do

		it 'sets an entry_station variable' do
			subject = described_class.new(station,station)
			expect(subject.entry_station).to eq station
		end

		it 'sets an exit_station variable' do
			subject = described_class.new(station,station)
			expect(subject.exit_station).to eq station
		end

	end

	describe '#calculate_fare' do
		it 'should return a number greater than 0' do		
			subject.entry_station = station
			subject.exit_station = exit_station
			expect(subject.fare).to be > 0
		end
	end
end