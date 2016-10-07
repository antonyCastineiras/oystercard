require './lib/oystercard'
require './lib/journey'
require './lib/journeylog'
require './lib/station'

@card = Oystercard.new(90)
@station1 = Station.new(:name1,1)
@station2 = Station.new(:name2,2)
@station3 = Station.new(:name3,3)
@station4 = Station.new(:name4,4)
@station5 = Station.new(:name5,5)
@station6 = Station.new(:name6,6)
@station7 = Station.new(:name7,7)
@station8 = Station.new(:name8,8)


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

puts "station 2 to 8"
new_card
@card.touch_in(@station2)
@card.touch_out(@station8)
print_card_details

=begin
stations = [1,2,3,4,5,6,7,8]

stations.each do |station_numberA|
	stations.each do |station_numberB|
		puts "station #{station_numberA} to #{station_numberB}"
		stationA = "@station#{station_numberA}"
		stationB = "@station#{station_numberB}"
		@card.touch_in(stationA)
		@card.touch_out(stationB)
		print_card_details
	end
end
=end