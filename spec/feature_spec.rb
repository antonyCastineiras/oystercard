require './lib/oystercard'
require './lib/journey'
require './lib/journeylog'
require './lib/station'

@card = Oystercard.new(90)
@station1 = Station.new(:name1,1)
@station2 = Station.new(:name2,2)

def print_card_details
	puts """
CARD BALANCE: #{@card.balance}
CURRENT JOURNEY: #{@card.current_journey}
JOURNEYS: #{@card.journey_log.journeys}
	"""
end


@card.touch_out(@station1)
@card.touch_out(@station2)
print_card_details