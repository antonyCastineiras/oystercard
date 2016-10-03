class OysterCard

attr_accessor :balance

 MAX_BALANCE = 90

 def initialize
   @balance = 0
 end

 def top_up(amount)
  fail "Exceeding maximum balance of #{MAX_BALANCE}, enter lower amount" if @balance + amount > MAX_BALANCE
 	@balance += amount
 end

 def deduct(amount)
 	@balance -= amount
 end

end
