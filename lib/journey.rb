class Journey

	MINIMUM_FARE = 1
	PENALTY_FARE = 6

	attr_accessor :entry_station, :exit_station, :fare 

	def initialize(entry_station = nil, exit_station = nil)
		@entry_station = entry_station
		@fare = PENALTY_FARE
	end

	def complete?
	!@entry_station.nil? && !@exit_station.nil?
	end

	def finish(station)
		@exit_station = station
		self
	end

	def fare
	@entry_station == nil ||@exit_station == nil ? @fare = PENALTY_FARE : @fare = MINIMUM_FARE	
	end


end
