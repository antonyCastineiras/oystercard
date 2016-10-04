require 'oyster_card'

describe OysterCard do

	 let(:station) { double(:station, :name => "entry_station", :zone => 1) }
	 let(:exit_station) { double(:station, :name => "exit_station", :zone => 2) }
	 let(:journey) { double(:jourey, :fare => 1)}

   describe '#initalize' do
		it 'creates a card with a balance of 0' do
			expect(subject.balance).to eq 0
		end

		it 'creates an entry_station variable set to nil' do
			expect(subject.entry_station).to eq nil
		end

		it 'has an empty list of journeys' do
			expect(subject.journeys).to eq []
		end

	 end

		describe '#top_up' do
			it {is_expected.to respond_to(:top_up).with(1).argument}

			it 'increases the balance instance variable' do
				initial_balance = subject.balance
				subject.top_up(10)
				updated_balance = subject.balance
				expect(updated_balance).to eq(10)
			end

			it 'won\'t let you top up to over maximum balance' do
				subject.top_up(described_class::MAX_BALANCE)
			  expect{ subject.top_up(1) }.to raise_error "Exceeding maximum balance of #{described_class::MAX_BALANCE}, enter lower amount"
			end
		end

		describe '#deduct' do

			it 'takes money of the card' do
				subject.top_up(described_class::MAX_BALANCE)
				subject.send(:deduct, 10)
				expect(subject.balance).to eq described_class::MAX_BALANCE - 10
			end
		end

		describe '#in_journey?' do
			it 'checks if the card is in use' do
       expect(subject.in_journey?).to be(true).or be(false)
			end
		end

		describe '#touch_in' do
			it 'changes the in_journy to true' do
				subject.top_up(2)
				subject.touch_in(station)
				expect(subject.in_journey?).to be(true)
			end

			it 'records the station touched in at' do
				subject.top_up(10)
				subject.touch_in(station)
				expect(subject.entry_station).to eq(station)
			end

			it 'raises an error when journy exceeds balance' do
				subject.top_up(0.5)
				expect{subject.touch_in(station)}.to raise_error "Insufficient funds for journey"
			end
		end

		describe '#touch_out' do
			it 'changes the in_journy to false' do
				subject.top_up(2)
				subject.touch_in(station)
				subject.touch_out(station)
				expect(subject.in_journey?).to be(false)
			end

      it 'updates the balance when journy is over' do
      	subject.top_up(described_class::MAX_BALANCE)
      	initial_balance = subject.balance
				subject.touch_in(station)
				subject.touch_out(exit_station)
				expect(subject.balance).to be < initial_balance
      end

      it 'updates the entry_station variable to nil' do
      	subject.top_up(10)
      	subject.touch_in(station)
      	subject.touch_out(exit_station)
      	expect(subject.entry_station).to eq nil
      end

			it 'stores the exit station' do
				subject.top_up(10)
      	subject.touch_in(station)
      	subject.touch_out(exit_station)
				expect(subject.journeys[0]).to include(:exit_station => exit_station)
			end
		end

		describe '#create_journey' do
			it 'records a journey as a hash' do
				subject.top_up(10)
      	subject.touch_in(station)
      	subject.touch_out(exit_station)
				expect(subject.journeys[0]).to include(:entry_station => station, :exit_station => exit_station)
			end

			it 'creates one journey for every touch in/out' do
				subject.top_up(10)
      	subject.touch_in(station)
      	subject.touch_out(exit_station)
				expect(subject.journeys.length).to eq 1 
			end
		end
end
