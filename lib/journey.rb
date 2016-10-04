require_relative 'station'
require_relative 'oyster_card'

class Journey

	attr_reader :entry_station, :exit_station, :fare

	def initialize(entry_station=nil, exit_station=nil)
		@entry_station = entry_station
		@exit_station = exit_station
		@fare = calculate_fare
	end

	def calculate_fare
		if penalty_fare?
			6
		else
		  (@entry_station.zone - @exit_station.zone).abs
	  end
	end

	def penalty_fare?
    if @entry_station == nil || @exit_station == nil then true end
  end

end
