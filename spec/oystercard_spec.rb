require 'oyster_card'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:start_station) { double :start_station}
  let(:exit_station) { double :exit_station }
  let(:journey) { {start_station: start_station, exit_station: exit_station} }

  describe 'initialized card' do

    before do
      card.topup(Oystercard::MAX_BALANCE)
    end

    it "checks that card has an empty list of journeys by default" do
      expect(card.journeys).to be_empty
    end

    it "should have an opening balance = 0" do
      expect(Oystercard::DEFAULT_BALANCE).to eq(0)
    end

    it "stores journeys on the card" do
      card.touch_in(start_station)
      card.touch_out(exit_station)
      expect(card.journeys).to include journey
    end

  end


  describe '#in_journey'  do
    it "will know when the card is in journey" do
      card.topup(1.0)
      card.touch_in(start_station)
      expect(card.in_journey?).to eq true
    end
  end

  describe '#touch_in' do

    it "will change the in_journey status to true" do
      card.topup(described_class::MAX_BALANCE)
      card.touch_in(start_station)
      expect(card).to be_in_journey
    end

    it "stores the entry station" do
      card.topup(described_class::MAX_BALANCE)
      card.touch_in(start_station)
      expect(card.start_station).to eq start_station
    end

    it "will only allow a card to touch_in if there are sufficient funds" do
      expect{ card.touch_in(start_station) }.to raise_error "Not enough funds on card."
    end

  end


  describe '#touch_out' do

    it "will change the in_journey status to false" do
      card.topup(described_class::MAX_BALANCE)
      card.touch_in(start_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it "will cause the card to forget start_station" do
      card.topup(described_class::MAX_BALANCE)
      card.touch_in(start_station)
      card.touch_out(exit_station)
      expect(card.start_station).to eq nil
    end

    it "will deduct the correct amount for the journey" do
      expect{ card.touch_out(exit_station) }.to change { card.balance }.by(-described_class::MINIMUM_FARE)
    end




  end

  describe '#topup' do

    it "tops up the card with additional funds, and increases the balance by that amount" do
      expect{ card.topup(10) }.to change{ card.balance }.by(10)
    end

    it "sets a maximum topup limit of 90 pounds sterling" do
      card.topup(described_class::MAX_BALANCE)
      expect{ card.topup(1) }.to raise_error "Error, this will exceed the £#{described_class::MAX_BALANCE} maximum balance."
    end
  end
end
