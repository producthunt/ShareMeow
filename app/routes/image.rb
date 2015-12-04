require 'app/digest_authorization'

module ShareMeow
  module Routes
    class Image < Sinatra::Application
      helpers Sinatra::DigestAuthorization

      configure do
        set :logging, true

        disable :method_override

        enable :use_code
      end

      get '/image' do
        content_type :json

        { url: ShareMeow::Image.new(params).generate_and_store! }.to_json
      end

      get '/v1/:encoded_params/:encoded_hmac_digest/image.jpg' do
        content_type :jpeg

        unless authorized?(encoded_params: params[:encoded_params], encoded_hmac_digest: params[:encoded_hmac_digest])
          halt 401, 'Not authorized'
        end

        decoded_params = Base64.urlsafe_decode64(params[:encoded_params])
        ShareMeow::Image.new(JSON.parse(decoded_params)).to_jpg
      end
    end
  end
end
