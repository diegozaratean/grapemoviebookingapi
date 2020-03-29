require "test_helper"
require 'models/booking'
require 'models/movie'
require 'app'

describe "Booking" do
	include Rack::Test::Methods

	def app
		API::App
	end

	describe "Create Booking " do
		before do
			post "/bookings", booking: {
				name:"Diego Zarate",
				movieid:1, 
				date:"2019-09-10"				
			}
		end

		it "Create booking " do
			last_response.status.equal?(201)	
		end

		it "Shows the name" do
			#require "pry"; binding.pry
			last_response.body.include?("Diego Zarate")
  		end
		
	end

	describe "List Bookings " do
		before do
			get "/bookings"
		end

		it "provides a valid response" do
			last_response.status.equal?(201)	
		end

		it "List all bookings" do
			last_response.body.include?("Diego Zarate")
  		end		
	end
end