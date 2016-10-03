class Oystercard
  attr_reader :balance, :max_limit
  DEFAULT_MAX_LIMIT = 90

  def initialize(limit=DEFAULT_MAX_LIMIT)
    @balance = 0
    @max_limit = limit
  end

  def top_up(value)
    fail "Can't top up to more than #{@max_limit} GBP" if exceeds_limit?(value)
    @balance += value 
  end

  def deduct(fare)
    fail "You do not have enough money on your Oystercard" if no_money?(fare) 
    @balance -= fare
  end


  private

  def no_money?(fare)
    (@balance - fare) < 0
  end

  def exceeds_limit?(value)
    (@balance + value) > @max_limit
  end
end
