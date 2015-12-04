require 'spec_helper'

RSpec.describe ShareMeow::App do
  describe '/:encoded_params/:hmac_digest/image.jpg' do
    let(:image_double) do
      instance_double(ShareMeow::Image, to_jpg: 'fake-image')
    end

    let(:encoded_params) do
      Base64.urlsafe_encode64({ template: 'HelloWorld', message: 'Hello, World' }.to_json)
    end

    let(:secret_key) do
      ENV['SHARE_MEOW_SECRET_KEY']
    end

    let(:hmac_digest) do
      hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'.freeze), secret_key, encoded_params)
      Base64.urlsafe_encode64([hmac].pack('H*'))
    end

    before do
      allow(ShareMeow::Image).to receive(:new).and_return image_double
    end

    it 'renders the image and returns a jpg' do
      get "/v1/#{encoded_params}/#{hmac_digest}/image.jpg"

      expect(last_response.body).to eq 'fake-image'
      expect(last_response.content_type).to eq 'image/jpeg'
    end

    it 'returns a 401 if different params are sent' do
      get "/v1/thisiswrong/#{hmac_digest}/image.jpg"

      expect(last_response.status).to eq 401
    end

    it 'passes all params on to Image' do
      get "/v1/#{encoded_params}/#{hmac_digest}/image.jpg"

      expect(ShareMeow::Image).to have_received(:new).with('template' => 'HelloWorld', 'message' => 'Hello, World')
    end

    context 'invalid key' do
      let(:secret_key) { 'thisiswrong' }

      it 'returns a 401 with invalid hmac digest' do
        get "/v1/#{encoded_params}/#{hmac_digest}/image.jpg"

        expect(last_response.status).to eq 401
      end
    end
  end
end
