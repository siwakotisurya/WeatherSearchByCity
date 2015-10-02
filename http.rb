require "httparty" 

class GoogleSearch

	include HTTParty

	base_uri "http://api.openweathermap.org/data/2.5"

	def json_parser
		puts "just a moment please system is handling your request"
		puts "."*10
		find_keyword = self.class.get("/weather?q=#{@location}.json")
		@json = JSON.parse(find_keyword.body)
	end

	def find
		puts "Todays Weather for #{@location} is Below"
		puts "Longitude :  #{@json["coord"]["lon"]}"
		puts "Latitude: #{@json["coord"]["lat"]}"
		puts "Current Temperature: #{@json["main"]["temp"]-272.15} degree celcius"
		puts "Counrty: #{@json["sys"]["country"]}"
		puts "Humidity: #{@json["main"]["humidity"]}%"
		puts "Wind Spped: #{@json["wind"]["speed"]}m/s"
		@json["weather"].each do |s|
			puts "Cloud:  #{s["description"]}"
		end
		puts "HTTP Resonse Status Code #{@json["cod"]}"
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
search.json_parser
search.find

