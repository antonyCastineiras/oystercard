require_relative 'journey'
require_relative 'station'

class OysterCard

attr_accessor :balance, :entry_station, :exit_station, :journeys

 MAX_BALANCE = 90
 MINIMUM_JOURNEY_COST = 1

 def initialize
   @balance = 0
   @entry_station = nil
   @exit_station = nil
   @journeys = []
 end

 def top_up(amount)
  fail "Exceeding maximum balance of #{MAX_BALANCE}, enter lower amount" if @balance + amount > MAX_BALANCE
 	@balance += amount
 end

 def in_journey?
   if @entry_station then true else false end
 end

 def touch_in(station)
 	 fail "Insufficient funds for journey" if @balance < MINIMUM_JOURNEY_COST
   @in_journey = true
   @entry_station = station
 end

 def touch_out(station)
  @in_journey = false
  @exit_station = station
  journey = create_journey
  deduct(journey.fare)
  reset_stations
 end


 private

 def create_journey
   h = {}
   h[:entry_station] = @entry_station
   h[:exit_station] = @exit_station
   @journeys << h
   journey = Journey.new(@entry_station,@exit_station)
 end

 def reset_stations
  @entry_station = nil
  @exit_station = nil
 end

 def deduct(amount = MINIMUM_JOURNEY_COST )
   @balance -= amount
 end

end
