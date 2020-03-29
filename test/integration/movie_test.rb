require "test_helper"
require 'models/movie'
require 'app'

describe "Movie" do
	include Rack::Test::Methods

	def app
		API::App
	end

	describe "Create Movie " do
		before do
			post "/movies", movie: {
				name:"life of pi",
				description:"a beatufill adventure of a castaway..",
				imageurl:"https://1.bp.blogspot.com/-BTEuLGFaHxw/URhURgz67wI/AAAAAAAAIPQ/LG-it4UcwxI/s1600/life-of-pi-LifeOfPi_VerA_Poster_rgb.jpg",
				begindate:"2019-09-10",
				enddate:"2019-11-10"
			}
		end

		it "Create movies" do
			last_response.status.equal?(201)	
		end

		it "Shows the name" do
			#require "pry"; binding.pry
			last_response.body.include?("life of pi")
  		end

		it "Shows the description" do
			last_response.body.include?("a beatufill adventure of a castaway..")
		end
	end

	describe "List Movies " do
		before do
			get "/files"
		end

		it "provides a valid response" do
			last_response.status.equal?(201)	
		end

		it "List all movies" do
			#require "pry"; binding.pry
			last_response.body.include?("life of pi")
  		end

		it "List all movies info" do
			last_response.body.include?("a beatufill adventure of a castaway..")
		end
	end
end