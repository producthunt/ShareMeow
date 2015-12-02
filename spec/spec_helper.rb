require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RACK_ENV'] = 'test'
ENV['AWS_BUCKET_NAME'] = 'sharemeow'
ENV['AUTH_USERNAME'] = 'sharemeow'
ENV['AUTH_PASSWORD'] = 'very_secure'

require File.expand_path('../../app', __FILE__)

require 'rspec'
require 'rack/test'
require 'pry-byebug'

def app
  described_class
end

# Stub all Aws calls
Aws.config[:stub_responses] = true

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
