require 'oyster_card'

describe OysterCard do

   describe '#initalize' do
		it 'creates a card with a balance of 0' do
			expect(subject.balance).to eq 0
		end

   end
end
