require 'journey'
require 'station'
require 'oyster_card'

describe Journey do

	let(:station) { double(:station, :name => :station, :zone => 1) }
	let(:exit_station) { double(:station, :name => :exit_station, :zone => 2)}

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
			card = OysterCard.new
			station = Station.new(:entry)
			exit_station = Station.new(:exit)
			card.top_up(23)
			card.touch_in(station)
			card.touch_out(exit_station)
			expect((station.zone - exit_station.zone).abs).to be > 0
		end

		it 'should return the penalty fare if you don\'t touch out' do
			card = OysterCard.new
			station = Station.new(:entry)
			card.top_up(21)
			card.touch_in(station)
			expect(subject.calculate_fare).to eq 6
		end
	end
end
