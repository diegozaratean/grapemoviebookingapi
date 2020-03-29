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
				@movie = Movie.new params[:movie]
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
	end
end