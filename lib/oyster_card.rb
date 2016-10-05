class Oystercard

  DEFAULT_BALANCE = 0.0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

 
  attr_reader :balance, :start_station, :journeys

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
    @journeys = []
  end


  def topup(funds)
    fail "Error, this will exceed the £#{MAX_BALANCE} maximum balance." if (balance + funds) > MAX_BALANCE
    @balance = @balance + funds
  end

  def touch_in(start_station)
    fail "Not enough funds on card." if @balance < MINIMUM_FARE
    @start_station = start_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    create_journey
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    !!@start_station
  end

  private

  def deduct(amount)
    @balance = @balance - amount
  end

  def create_journey
    @journeys << {beginning: @start_station, end: @exit_station}
    reset_stations
  end

  def reset_stations
    @start_station = nil
    @exit_station = nil
  end

end
