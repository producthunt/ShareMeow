module ShareMeow
  module Routes
    class Base < Sinatra::Application
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

      post '/image' do
        content_type :json
        param :template, String, required: true

        { url: ShareMeow::Image.new(params).generate_and_store! }.to_json
      end
    end
  end
end
