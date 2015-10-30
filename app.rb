require 'rubygems'
require 'bundler'

# Setup load paths
Bundler.require
$LOAD_PATH << File.expand_path('../', __FILE__)
$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'dotenv'
Dotenv.load

# Require base
require 'sinatra/base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/json'

Dir['lib/**/*.rb'].sort.each { |file| require file }

require 'app/helpers'
require 'app/routes'
require 'app/render_image'

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
