
require 'rubygems'
require 'bundler'
Bundler.require

require './app'
use Rack::Static, :urls => %w(/base.css /images /vendor), :root => "public"
run App
