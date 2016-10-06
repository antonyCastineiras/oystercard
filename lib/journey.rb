class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  attr_accessor :exit_station, :entry_station, :fare

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def in_journey?
    !!@entry_station
  end

  def penalty_fare
    PENALTY_FARE
  end

  def calculate_fare
    @entry_station == nil || @exit_station == nil ? 0 : (@entry_station.zone - @exit_station.zone).abs
  end
end
