require 'spec_helper'

RSpec.describe ShareMeow::App do
  describe '/:encoded_params/:hmac_digest/image.jpg' do
    let(:image_double) do
      instance_double(ShareMeow::Image, to_jpg: 'fake-image')
    end

    let(:encoded_params) do
      Base64.urlsafe_encode64({ template: 'HelloWorld', message: 'Hello, World' }.to_json)
    end

    let(:hmac_digest) do
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'.freeze), ENV['SHARE_MEOW_SECRET_KEY'], encoded_params)
    end

    before do
      allow(ShareMeow::Image).to receive(:new).and_return image_double
    end

    it 'renders the image and returns a jpg' do
      get "/#{encoded_params}/#{hmac_digest}/image.jpg"

      expect(last_response.body).to eq 'fake-image'
      expect(last_response.content_type).to eq 'image/jpeg'
    end

    it 'returns a 401 with invalid hmac digest' do
      get "/#{encoded_params}/thisiswrong/image.jpg"

      expect(last_response.status).to eq 401
    end

    it 'returns a 401 if different params are sent' do
      get "/thisiswrong/#{hmac_digest}/image.jpg"

      expect(last_response.status).to eq 401
    end

    it 'passes all params on to Image' do
      get "/#{encoded_params}/#{hmac_digest}/image.jpg"

      expect(ShareMeow::Image).to have_received(:new).with('template' => 'HelloWorld', 'message' => 'Hello, World')
    end
  end
end
