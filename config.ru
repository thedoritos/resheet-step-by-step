require 'bundler/setup'

Dir['./resheet/**/*.rb'].each { |f| require f }

use Rack::Auth::Basic do |username, password|
  username == ENV['BASIC_AUTH_USERNAME']  && password == ENV['BASIC_AUTH_PASSWORD']
end

run Resheet::App

