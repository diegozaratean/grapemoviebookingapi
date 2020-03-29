require "bundler"
Bundler.require
Bundler.require :test
require 'dotenv/load'

require "minitest/autorun"


connect = "postgres://" + ENV['POSTGRESQL_USERNAME'] + ":" + ENV['POSTGRESQL_PASSWORD'] + "@" + ENV['POSTGRESQL_HOST'] + ":" + ENV['POSTGRESQL_PORT'] + "/" + ENV['POSTGRESQL_DATABASE']
Sequel.connect(connect)