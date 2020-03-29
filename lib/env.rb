require "bundler"
Bundler.require
Bundler.require :production
require 'dotenv/load'


connect = "postgres://" + ENV['POSTGRESQL_USERNAME'] + ":" + ENV['POSTGRESQL_PASSWORD'] + "@" + ENV['POSTGRESQL_HOST'] + ":" + ENV['POSTGRESQL_PORT'] + "/" + ENV['POSTGRESQL_DATABASE']
Sequel.connect(connect)