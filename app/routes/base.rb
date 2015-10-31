module ShareMeow
  module Routes
    class Base < Sinatra::Application
      register ShareMeow::Authorization

      configure do
        set :logging, true
        set :views, 'app/views'

        disable :method_override
        disable :protection
        disable :static

        enable :use_code
      end

      get '/' do
        'ShareMeow 😻'
      end
    end
  end
end
