require_relative 'journey'
require_relative 'journey_log'
require_relative 'station'

class Oystercard

  DEFAULT_BALANCE = 0.0
  MAX_BALANCE = 90

  attr_reader :balance, :entry_station

  def initialize
    @balance = DEFAULT_BALANCE
    @journey_log = JourneyLog.new(Journey.new)
  end


  def topup(funds)
    fail "Error, this will exceed the £#{MAX_BALANCE} maximum balance." if (balance + funds) > MAX_BALANCE
    @balance = @balance + funds
  end

  def touch_in(entry_station)
    fail "Not enough funds on card." if @balance < Journey::MINIMUM_FARE
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.current_journey.fare)
  end

  private

  def deduct(amount)
    @balance = @balance - amount
  end

end
