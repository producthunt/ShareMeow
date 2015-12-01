require 'spec_helper'

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

    it 'returns url to generated image' do
      allow(ShareMeow::Image).to receive(:new).and_return image_double

      post '/image', template: 'HelloWorld', message: 'Hello, World'

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['url']).to eq 'https://example.com/fake.jpg'
    end

    it 'passes all params on to Image' do
      allow(ShareMeow::Image).to receive(:new).and_return image_double

      post '/image', template: 'HelloWorld', message: 'Hello, World'

      expect(ShareMeow::Image).to have_received(:new).with('template' => 'HelloWorld', 'message' => 'Hello, World')
    end

    it 'returns an error if the template param is missing' do
      post '/image', message: 'Hello, World'

      expect(JSON.parse(last_response.body)['errors']).to eq('template' => 'Parameter is required')
    end
  end
end
