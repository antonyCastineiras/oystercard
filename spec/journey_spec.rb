require 'journey'

describe Journey do

	subject { described_class.new(:entry_station, :exit_station)}
	let(:station) { double :station, zone: 1 }

	describe '#initialize' do

		it 'sets an entry_station variable' do
			expect(subject.entry_station).to eq :entry_station
		end

		it 'sets an exit_station variable' do
			expect(subject.exit_station).to eq :exit_station
		end
	end

	describe '#fare' do

		it 'returns the minimum if stations equal nil' do
			subject {described_class.new(nil,nil)}
			expect(subject.fare).to eq described_class::MINIMUM_FARE
		end
	end
end
