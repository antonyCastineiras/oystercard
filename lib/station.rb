class Station
	attr_reader :zone, :name
	def initialize(name,zone=rand(8))
		@zone = zone
		@name = name
	end
end

