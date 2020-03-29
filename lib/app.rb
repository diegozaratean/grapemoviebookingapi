module API
	class App < Grape::API

		use Rack::Config do |env|
			env['api.tilt.root'] = File.join Dir.pwd, "lib/views"
		end

		format :json
		default_format :json
		formatter :json, Grape::Formatter::Rabl

		resource :movies do

			post "/", rabl: "movies/item"  do
				@movie = Movie.new(name: params["name"],description: params["description"],imageurl: params["imageurl"],begindate: params["begindate"],enddate: params["enddate"])
				@movie.save	
			end

			params do
				optional :date, type: String
				optional :weekday, type: Integer
			end
			get "/", rabl: "movies/collection"  do				
				if params && params[:date]
					date = params[:date]
					@movies = Movie.where{begindate < date }.where{enddate > date }
				elsif params && params[:weekday]
					today = Date.today
					if today.wday > params[:weekday]
						date = today + (7 - today.wday) + params[:weekday]
					elsif today.wday == params[:weekday]
						date = today	
					else
						date = today + (params[:weekday] - today.wday)
					end
					@movies = Movie.where{begindate < date }.where{enddate > date }
				else
					@movies = Movie.all
				end	
			end

			params do
				requires :id, type: Integer
			end
			get "/:id" , rabl: "movies/item" do
				@movie = Movie[params[:id]]
			end
		end

		resource :bookings do

			post "/", rabl: "bookings/item"  do
				dateparms = params["date"]
				movie_id = params["movieid"]
				@bookings = Booking.where{(date =~ dateparms ) & (movieid =~ movie_id)}
				if @bookings.count < 10
					@booking = Booking.new(movieid: params["movieid"],date: params["date"],name: params["name"])
					@booking.save
				else
					error_msg = "Can't make reservation the movie you want is full on that date"
    				error!({ 'error_msg' => error_msg }, 409)
				end
			end

			params do
				optional :date, type: String
				optional :begindate, type: String
				optional :enddate, type: String
			end
			get "/", rabl: "bookings/collection"  do				
				if params && params[:date]
					@bookings = Booking.where(date: params[:date])
				elsif params && params[:begindate] && params[:enddate]
					@bookings = Booking.where(date: params[:begindate]..params[:enddate])
				else
					@bookings = Booking.all
				end	
			end

			params do
				requires :id, type: Integer
			end
			get "/:id" , rabl: "bookings/item" do
				@booking = Booking[params[:id]]
			end
		end
	end
end