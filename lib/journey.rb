class Journey

	MINIMUM_FARE = 1
	PENALTY_FARE = 6

	attr_reader :entry_station, :exit_station, :fare


	def initialize(entry_station,exit_station)
		@entry_station = entry_station
		@exit_station = exit_station
		@fare = determine_fare
	end

	def determine_fare
	@entry_station.nil? || @exit_station.nil? ? PENALTY_FARE : MINIMUM_FARE 
	end

end
