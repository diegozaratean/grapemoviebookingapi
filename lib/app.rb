module API
	class App < Grape::API

		use Rack::Config do |env|
			env['api.tilt.root'] = File.join Dir.pwd, "lib/views"
		end		
	end
end