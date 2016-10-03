require 'oyster_card'

describe OysterCard do


   describe '#initalize' do
		it 'creates a card with a balance of 0' do
			expect(subject.balance).to eq 0
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
			it {is_expected.to respond_to(:deduct).with(1).argument}

			it 'takes money of the card' do
				subject.top_up(described_class::MAX_BALANCE)
				subject.deduct(10)
				expect(subject.balance).to eq described_class::MAX_BALANCE - 10
			end
		end

   end
end
