
class JourneyLog

	attr_reader :journey_class

	def initialize(journey_class)
		@journey_class = journey_class
	end

	def start
		entry_station = @journey_class.entry_station
	end
end
