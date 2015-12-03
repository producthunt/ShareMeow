require 'spec_helper'
require 'base64'

RSpec.describe ShareMeow::App do
  let(:basic_auth) { "Basic #{Base64.encode64('sharemeow:very_secure')}" }

  describe '/image' do
    let(:image_double) do
      instance_double(ShareMeow::Image, generate_and_store!: 'https://example.com/fake.jpg')
    end

    it 'generates the image and returns the url' do
      allow(ShareMeow::Image).to receive(:new).and_return image_double

      get '/image', { template: 'HelloWorld', message: 'Hello, World' },
          'HTTP_AUTHORIZATION' => basic_auth

      expect(JSON.parse(last_response.body)['url']).to eq 'https://example.com/fake.jpg'
    end

    it 'returns a 401 without username/password' do
      allow(ENV).to receive(:[]).with('AUTH_ENABLED').and_return 'false'
      get '/image', { template: 'HelloWorld', message: 'Hello, World' }

      expect(last_response.status).to eq 200
    end

    it 'does not require AUTH if env var is set' do

    end

    it 'returns a 401 with wrong credentials' do
      get '/image', 'HTTP_AUTHORIZATION' => "Basic #{Base64.encode64('thisiswrong:sowrong')}"

      expect(last_response.status).to eq 401
    end

    it 'passes all params on to Image' do
      allow(ShareMeow::Image).to receive(:new).and_return image_double

      get '/image', { template: 'HelloWorld', message: 'Hello, World' },
          'HTTP_AUTHORIZATION' => basic_auth

      expect(ShareMeow::Image).to have_received(:new).with('template' => 'HelloWorld', 'message' => 'Hello, World')
    end

    it 'returns an error if the template param is missing' do
      get '/image', { message: 'Hello, World' }, 'HTTP_AUTHORIZATION' => basic_auth

      expect(JSON.parse(last_response.body)['errors']).to eq('template' => 'Parameter is required')
    end
  end

  describe '/image/inline' do
    let(:image_double) do
      instance_double(ShareMeow::Image, to_jpg: 'fake')
    end

    it 'renders the image inline' do
      allow(ShareMeow::Image).to receive(:new).and_return image_double
      allow(image_double).to receive(:to_jpg)

      get '/image/inline', { template: 'HelloWorld', message: 'Hello, World' },
          'HTTP_AUTHORIZATION' => basic_auth

      expect(ShareMeow::Image).to have_received(:new).with('template' => 'HelloWorld', 'message' => 'Hello, World')
      expect(image_double).to have_received(:to_jpg)
      expect(last_response.content_type).to eq 'image/jpeg'
    end

    it 'returns a 401 without username/password' do
      get '/image/inline'

      expect(last_response.status).to eq 401
    end
  end
end
