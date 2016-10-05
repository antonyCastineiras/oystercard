class Oystercard

  DEFAULT_BALANCE = 0.0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1


  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
    @journeys = []
  end


  def topup(funds)
    fail "Error, this will exceed the £#{MAX_BALANCE} maximum balance." if (balance + funds) > MAX_BALANCE
    @balance = @balance + funds
  end

  def touch_in(entry_station)
    fail "Not enough funds on card." if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    create_journey
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  private

  def deduct(amount)
    @balance = @balance - amount
  end

  def create_journey
    @journeys << Journey.new(@entry_station,@exit_station)
    reset_stations
  end

  def reset_stations
    @entry_station = nil
    @exit_station = nil
  end

end
