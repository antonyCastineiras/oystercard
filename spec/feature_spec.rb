require './lib/oystercard'
require './lib/journey'
require './lib/journeylog'
require './lib/station'

@card = Oystercard.new(90)
@station1 = Station.new(:name1,1)
@station2 = Station.new(:name2,2)
@station3 = Station.new(:name3,3)
@station4 = Station.new(:name4,4)

def print_card_details
	puts """
CARD BALANCE: #{@card.balance}
CURRENT JOURNEY: entry_station = #{@card.current_journey.entry_station}
JOURNEYS: #{@card.journey_log.journeys}
	"""
end

def new_card
	@card = Oystercard.new(90)
end

puts "touch in/out"
@card.touch_in(@station1)
@card.touch_out(@station2)
print_card_details

puts "touch in/in same station"
new_card
@card.touch_in(@station1)
@card.touch_in(@station1)
print_card_details

puts " touch in/in different station"
new_card
@card.touch_in(@station1)
@card.touch_in(@station2)
print_card_details

puts "touch out/out same station"
new_card
@card.touch_out(@station1)
@card.touch_out(@station1)
print_card_details

puts "touch out/out different station"
new_card
@card.touch_out(@station1)
@card.touch_out(@station2)
print_card_details

puts "station 1 to 3" 
new_card
@card.touch_in(@station1)
@card.touch_out(@station3)
print_card_details

puts "station 1 to 4"
new_card
@card.touch_in(@station1)
@card.touch_out(@station4)
print_card_details
