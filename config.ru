require 'bundler/setup'

Dir['./resheet/**/*.rb'].each { |f| require f }

run Resheet::App

