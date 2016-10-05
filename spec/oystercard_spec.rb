require 'oyster_card'
require 'journey'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:entry_station) { double :entry_station}
  let(:exit_station) { double :exit_station }
  let(:journey) {double :journey }

  before do |example|
    allow(journey).to receive(:fare) {-Journey::PENALTY_FARE}
    unless example.metadata[:skip_before]
      card.topup(Oystercard::MAX_BALANCE)
    end
  end

  describe 'initialized card' do

    it "checks that card has an empty list of journeys by default" do
      expect(card.journeys).to be_empty
    end

    it "should have an opening balance = 0", skip_before: true do
      expect(Oystercard::DEFAULT_BALANCE).to eq(0)
    end

    it "stores journeys on the card" do
      initial_count = subject.journeys.count
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys.count).to be > initial_count
    end
  end

  describe '#in_journey'  do
    it "will know when the card is in journey" do
      card.touch_in(entry_station)
      expect(card.in_journey?).to eq true
    end
  end

  describe '#touch_in' do

    it "will change the in_journey status to true" do
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it "stores the entry station" do
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
    end

    it "will only allow a card to touch_in if there are sufficient funds", skip_before: true do
      expect{ card.touch_in(entry_station) }.to raise_error "Not enough funds on card."
    end

  end

  describe '#touch_out' do

    it "will change the in_journey status to false" do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it "will cause the card to forget entry_station" do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end

    it "will deduct the correct amount for the journey" do
      expect{ card.touch_out(exit_station) }.to change { card.balance }.by(journey.fare)
    end
  end

  describe '#topup' do

    it "tops up the card with additional funds, and increases the balance by that amount", skip_before: true do
      expect{ card.topup(10) }.to change{ card.balance }.by(10)
    end

    it "sets a maximum topup limit of 90 pounds sterling" do
      expect{ card.topup(1) }.to raise_error "Error, this will exceed the £#{described_class::MAX_BALANCE} maximum balance."
    end
  end
end
