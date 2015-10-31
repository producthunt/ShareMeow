require 'spec_helper'

RSpec.describe ShareMeow::Authorization do
  class FakeApp < Sinatra::Application
    register ShareMeow::Authorization
  end

  describe '#authorized' do
    let(:payload) do
      { name: 'William Shakespurr' }.to_json
    end

    let(:hexdigest) do
      digest = OpenSSL::Digest.new('sha1')
      OpenSSL::HMAC.hexdigest(digest, 'my_secret_share_meow_key', payload)
    end

    context 'has the correct key' do
      it 'validates the digest/payload' do
        stub_const('ShareMeow::Authorization::AUTH_KEY', 'my_secret_share_meow_key')

        expect(FakeApp.authorized?(hexdigest, payload)).to eq true
      end
    end

    context 'has an invalid key' do
      it 'validates the digest/payload' do
        stub_const('ShareMeow::Authorization::AUTH_KEY', 'this_is_the_wrong_key!')

        expect(FakeApp.authorized?(hexdigest, payload)).to eq false
      end
    end
  end
end
