require "httparty" 

class GoogleSearch

	include HTTParty

	base_uri "http://api.openweathermap.org/data/2.5"

	def json_parser
		puts "just a moment please system is handling your request"
		puts "."*20
		@json = self.class.get("/weather?q=#{@location}.json")
	end

	def error_handler
		user_ask
		json_parser
		case @json.code
			when 200
				puts @json.code
				find
			when 404
				puts "sorry nothing match"
		end
	end

	def find
		puts "Todays Weather for #{@location} is Below"
		puts "Longitude:#{@json["coord"]["lon"]}"
		puts "Latitude:#{@json["coord"]["lat"]}"
		puts "Current Temperature: #{@json["main"]["temp"]-272.15} degree celcius"
		puts "country: #{@json["sys"]["country"]}"
		puts "humidity: #{@json["main"]["humidity"]}%"
		puts "Wind Spped: #{@json["wind"]["speed"]}m/s"
		@json["weather"].each do |s|
			puts "Cloud:#{s["description"]}"
		end
		puts "HTTP Resonse Status Code: #{@json["cod"]} #{@json.message}"
	end

	def user_ask
		puts "Enter the city name for example kathmandu, london, delhi"
		input = gets.chomp
		if input.is_a?(String)
			@location = input
		else
			puts "Only string is allowed"
		end
 	end
end

search = GoogleSearch.new

search.error_handler

