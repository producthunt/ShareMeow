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
require 'sinatra/param'

Dir['lib/**/*.rb'].sort.each { |file| require file }
Dir['app/image_templates/*.rb'].each { |file| require file }

require 'app/authorization'
require 'app/routes'
require 'app/render_image'

module ShareMeow
  class App < Sinatra::Application
    configure do
      set :root, File.dirname(__FILE__)

      disable :method_override

      enable :static
      set :erb, escape_html: true
    end

    use Rack::Deflater
    use Rack::Standards

    # Routes
    use Routes::Base
  end
end
