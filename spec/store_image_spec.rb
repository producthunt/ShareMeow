require 'spec_helper'

RSpec.describe ShareMeow::StoreImage do
  describe '#store!' do
    it 'uploads the binary data to S3 and returns a URL' do
      stub_const('ShareMeow::StoreImage::BUCKET_NAME', 'test')

      image_url = described_class.new('fake.jpg', 'fake-data').store!

      expect(image_url).to eq 'https://test.s3.stubbed-region.amazonaws.com/fake.jpg'
    end
  end
end
