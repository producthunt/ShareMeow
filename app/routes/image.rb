module ShareMeow
  module Routes
    class Image < ShareMeow::Routes::Base
      use Rack::Auth::Basic, 'You need a password to do this' do |username, password|
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
