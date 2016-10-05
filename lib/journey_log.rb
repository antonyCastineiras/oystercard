class JourneyLog

	attr_reader :journey_class, :journeys
	attr_accessor :current_journey

	def initialize(journey_class)
		@journey_class = journey_class
		@journeys = []
	end

	def start(station)
		@current_journey = journey_class.new(station)
	end

	def finish(station)
		@current_journey.exit_station = station
		@journeys << @current_journey
		@current_journey = nil
	end

	def journeys
		@journeys.dup
	end

	private

	def current_journey
		@current_journey || journey_class.new
	end


end
