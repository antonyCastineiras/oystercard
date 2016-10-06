require_relative 'journey'
require_relative 'station'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :journeys, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    (@balance + amount) > MAXIMUM_BALANCE ? fail("Card limit of £#{MAXIMUM_BALANCE} has been reached.") :
    @balance += amount
  end

  def touch_in(entry_station)
    @balance < MINIMUM_BALANCE ? fail("Insufficient funds") :
    failed_to_touch_out? ? deduct(current_journey.penalty_fare) :
    @journey_log.start(entry_station)
  end


  def touch_out(exit_station)
    failed_to_touch_in? ? deduct(current_journey.penalty_fare) :   
    current_journey.exit_station = exit_station
    deduct(current_journey.calculate_fare)
    @journey_log.finish(exit_station)
  end


  def current_journey
    @journey_log.send(:current_journey)
  end

  private

  def failed_to_touch_out?
    current_journey.entry_station != nil
  end

  def failed_to_touch_in?
    current_journey.entry_station == nil
  end
  
  def deduct(amount)
    @balance -= amount
  end

end