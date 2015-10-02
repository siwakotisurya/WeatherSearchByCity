require "httparty" 

class GoogleSearch

	include HTTParty

	base_uri "http://api.openweathermap.org/data/2.5"

	def find
		puts "just a moment please system is handling your request"
		puts "."*10
		find_keyword = self.class.get("/weather?q=#{@location}.json")
		parse_json = JSON.parse(find_keyword.body)
	end

	def user_ask
		puts "Enter the city name for example kathmandu, london, delhi"
		input = gets.chomp
		if input == Fixnum
			puts "Only string is allowed"
		else
			@location = input
		end
 	end
end

search = GoogleSearch.new

search.user_ask

search.find

