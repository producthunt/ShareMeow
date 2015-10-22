require 'rubygems'
require 'bundler'

# Setup load paths
Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'dotenv'
Dotenv.load

# Require base
require 'sinatra/base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/json'

Dir['lib/**/*.rb'].sort.each { |file| require file }

require 'app/models'
require 'app/helpers'
require 'app/routes'

module ShareMeow
  class App < Sinatra::Application
    configure do
      set :root, File.dirname(__FILE__)

      disable :method_override
      disable :static

      set :erb, escape_html: true
    end

    use Rack::Deflater
    use Rack::Standards

    # Routes
    use Routes::Base
  end
end

include ShareMeow::Models
