require 'app/basic_auth'

module ShareMeow
  module Routes
    class Image < Sinatra::Application
      register Sinatra::Param

      configure do
        set :logging, true

        disable :method_override

        enable :use_code
      end

      use BasicAuth, 'You need a password to do this' do |username, password|
        username == ENV.fetch('AUTH_USERNAME') && password == ENV.fetch('AUTH_PASSWORD')
      end

      post '/image' do
        content_type :json
        param :template, String, required: true

        { url: ShareMeow::Image.new(params).generate_and_store! }.to_json
      end
    end
  end
end
