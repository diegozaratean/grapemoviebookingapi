$:.unshift File.expand_path "..", __FILE__

require "lib/env"
require 'lib/models/movie'
require "lib/app"


run API::App
