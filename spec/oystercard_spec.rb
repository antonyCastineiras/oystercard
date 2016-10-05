require 'oyster_card'
require 'journey'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:entry_station) { double :entry_station}
  let(:exit_station) { double :exit_station }
  let(:journey) {double :journey }
  let(:journey_log) { double(:journey_log, exit_station: station) }

  before do |example|
    allow(journey).to receive(:fare) {-Journey::PENALTY_FARE}
    unless example.metadata[:skip_before]
      card.topup(Oystercard::MAX_BALANCE)
    end
  end

  describe 'initialized card' do

    it "should have an opening balance = 0", skip_before: true do
      expect(Oystercard::DEFAULT_BALANCE).to eq(0)
    end

  end


  describe '#touch_in' do

    it "will only allow a card to touch_in if there are sufficient funds", skip_before: true do
      expect{ card.touch_in(entry_station) }.to raise_error "Not enough funds on card."
    end

  end

  describe '#touch_out' do

    it "will deduct the correct amount for the journey" do
      allow(:journey_log).to receive(:finish).with(1).argument
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
