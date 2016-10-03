require 'oyster_card'

describe OysterCard do

	 let(:station) { double(:station) }

   describe '#initalize' do
		it 'creates a card with a balance of 0' do
			expect(subject.balance).to eq 0
		end

		it 'creates an entry_station variable set to nil' do
			expect(subject.entry_station).to eq nil
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
				subject.touch_out
				expect(subject.in_journey?).to be(false)
			end

      it 'updates the balance when journy is over' do
      	subject.top_up(described_class::MAX_BALANCE)
				subject.touch_in(station)
				expect {subject.touch_out}.to change{subject.balance}.by(-described_class::MINIMUM_JOURNEY_COST)
      end

      it 'updates the entry_station variable to nil' do
      	subject.top_up(10)
      	subject.touch_in(station)
      	subject.touch_out
      	expect(subject.entry_station).to eq nil
      end
		end
end
