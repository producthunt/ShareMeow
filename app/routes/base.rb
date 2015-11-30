module ShareMeow
  module Routes
    class Base < Sinatra::Application
      register ShareMeow::Authorization
      register Sinatra::Param

      configure do
        set :logging, true
        set :views, 'app/views'

        disable :method_override
        disable :protection

        enable :static
        enable :use_code
      end

      get '/' do
        'ShareMeow 😻'
      end

      get '/image' do
        content_type :json
        param :digest, String, required: true
        param :payload, Hash, required: true

        'hi'
      end
    end
  end
end
