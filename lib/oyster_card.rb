class OysterCard

attr_accessor :balance, :entry_station

 MAX_BALANCE = 90
 MINIMUM_JOURNEY_COST = 1

 def initialize
   @balance = 0
   @entry_station = nil
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

 def touch_out
  @in_journey = false
  deduct
  @entry_station = nil
 end

 private

 def deduct(amount = MINIMUM_JOURNEY_COST )
   @balance -= amount
 end

end
