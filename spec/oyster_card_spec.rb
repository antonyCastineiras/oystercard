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
		end

   end
end
