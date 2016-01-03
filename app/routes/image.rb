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

      get '/v1/:encoded_params/:encoded_hmac_digest/image.jpg' do
        unless authorized?(encoded_params: params[:encoded_params], encoded_hmac_digest: params[:encoded_hmac_digest])
          halt 401, 'Not authorized'
        end

        content_type :jpeg
        cache_control :public, max_age: 31_536_000

        decoded_params = Base64.urlsafe_decode64(params[:encoded_params])
        ShareMeow::Image.new(JSON.parse(decoded_params)).to_jpg
      end
    end
  end
end
