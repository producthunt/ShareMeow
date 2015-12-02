require 'spec_helper'
require 'base64'

RSpec.describe ShareMeow::App do
  describe '/' do
    it 'loads root route' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'ShareMeow 😻'
    end
  end

  describe '/image' do
    let(:image_double) do
      instance_double(ShareMeow::Image, generate_and_store!: 'https://example.com/fake.jpg')
    end

    let(:basic_auth) { "Basic #{Base64::encode64('sharemeow:very_secure')}" }

    it 'returns a 401 without username/password' do
      post '/image'

      expect(last_response.status).to eq 401
    end

    it 'returns a 401 with wrong credentials' do
      post '/image', 'HTTP_AUTHORIZATION' => "Basic #{Base64::encode64('thisiswrong:sowrong')}"


      expect(last_response.status).to eq 401
    end

    it 'passes all params on to Image' do
      allow(ShareMeow::Image).to receive(:new).and_return image_double

      post '/image', { template: 'HelloWorld', message: 'Hello, World' },
        'HTTP_AUTHORIZATION' => basic_auth

      expect(ShareMeow::Image).to have_received(:new).with('template' => 'HelloWorld', 'message' => 'Hello, World')
    end

    it 'returns an error if the template param is missing' do
      post '/image', { message: 'Hello, World' }, 'HTTP_AUTHORIZATION' => basic_auth

      expect(JSON.parse(last_response.body)['errors']).to eq('template' => 'Parameter is required')
    end
  end
end
