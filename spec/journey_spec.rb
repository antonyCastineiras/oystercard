require 'journey'

describe Journey do
	
	subject { described_class.new(:entry_station, :exit_station)}

	describe '#initialize' do

		it 'sets an entry_station variable' do
			expect(subject.entry_station).to eq :entry_station
		end

		it 'sets an exit_station variable' do
			expect(subject.exit_station).to eq :exit_station
		end

	end

end