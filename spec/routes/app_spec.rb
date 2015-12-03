require 'spec_helper'

RSpec.describe ShareMeow::App do
  describe '/' do
    it 'loads root route' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'ShareMeow 😻'
    end
  end
end
