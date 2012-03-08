require 'bundler/setup'
Bundler.require(:test)

require_relative '../app'

include Rack::Test::Methods

def app
  Sinatra::Application
end
