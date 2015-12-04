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
require 'base64'
require 'openssl'
require 'pry-byebug' if ENV['RACK_ENV'] == 'development'

require 'app/image_templates/base'
Dir['app/image_templates/*.rb'].each { |file| require file }

require 'app/routes/base'
require 'app/routes/image'
require 'app/image'

module ShareMeow
  class App < Sinatra::Application
    register Sinatra::Initializers

    configure do
      set :root, File.dirname(__FILE__)

      if settings.development? || settings.test?
        set :base_url, 'http://localhost:3000'
      else
        set :base_url, ENV.fetch('BASE_URL')
      end

      disable :method_override

      enable :static
    end

    use Rack::SSL if environment == 'production'
    use Rack::Standards

    # Routes
    use Routes::Base
    use Routes::Image
  end
end
