ENV['RACK_ENV'] = 'test'

require File.expand_path('../../app', __FILE__)

require 'rspec'
require 'rack/test'
require 'pry-byebug'

def app
  described_class
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
