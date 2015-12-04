require 'spec_helper'

RSpec.describe ShareMeow::Image do
  let(:imgkit_double) { instance_double(IMGKit, to_img: 'fake-image', stylesheets: []) }

  let(:default_params) do
    { 'template' => 'HelloWorld', 'message' => 'Hello, World' }
  end

  describe '.new' do
    it 'uses the correct template' do
      allow(ImageTemplates::HelloWorld).to receive(:new)

      described_class.new(default_params)

      expect(ImageTemplates::HelloWorld).to have_received(:new).with(default_params)
    end

    it 'raises an error if template is not implemented' do
      expect do
        described_class.new('template' => 'Fake')
      end.to raise_error NotImplementedError, 'You must implement a Fake template'
    end
  end

  describe '#to_jpg' do
    let(:template_double) do
      instance_double(ImageTemplates::HelloWorld, to_html: 'fake',
                                                  image_width: 300,
                                                  css_stylesheet: 'fake.css',
                                                  image_quality: 100)
    end

    before do
      allow(IMGKit).to receive(:new).and_return imgkit_double
      allow(ImageTemplates::HelloWorld).to receive(:new).and_return template_double
    end

    it 'renders the template and returns the binary data' do
      image = described_class.new(default_params).to_jpg

      expect(imgkit_double).to have_received(:to_img).with(:jpg)
      expect(image).to eq 'fake-image'
    end

    it 'initializes IMGkit with the correct params' do
      described_class.new(default_params).to_jpg

      expect(IMGKit).to have_received(:new).with('fake', zoom: 2, width: 300, quality: 100)
    end
  end
end
