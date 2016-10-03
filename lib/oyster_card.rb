class OysterCard

attr_accessor :balance

 MAX_BALANCE = 90
 MINIMUM_JOURNEY_COST = 1

 def initialize
   @balance = 0
   @in_journey = false
 end

 def top_up(amount)
  fail "Exceeding maximum balance of #{MAX_BALANCE}, enter lower amount" if @balance + amount > MAX_BALANCE
 	@balance += amount
 end

 def deduct(amount)
 	@balance -= amount
 end

 def in_journey?
   @in_journey
 end

 def touch_in
 	 fail "Insufficient funds for journey" if @balance < MINIMUM_JOURNEY_COST
   @in_journey = true
 end

 def touch_out
  @in_journey = false
 end

end
