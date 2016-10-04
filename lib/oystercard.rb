class Oystercard
  attr_reader :balance, :max_limit, :in_journey
  DEFAULT_MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(limit=DEFAULT_MAX_LIMIT)
    @balance = 0
    @max_limit = limit
    @in_journey = false
  end

  def top_up(value)
    fail "Can't top up to more than #{@max_limit} GBP" if exceeds_limit?(value)
    @balance += value 
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
  end

  private

  def no_money?(fare)
    @balance <= MINIMUM_FARE
  end

  def deduct(fare)
    fail "You do not have enough money on your Oystercard" if no_money?(fare) 
    @balance -= fare
  end

  def exceeds_limit?(value)
    (@balance + value) > @max_limit
  end
end
