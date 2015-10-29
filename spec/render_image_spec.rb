require 'spec_helper'

RSpec.describe ShareMeow::RenderImage do
  describe '.call' do
    let(:imgkit_double) { instance_double(IMGKit, to_img: 'fake-image') }

    let(:template_double) do
      instance_double(ImageTemplates::Comment, to_html: 'fake html', image_width: 100, image_quality: 100)
    end

    before do
      allow(IMGKit).to receive(:new).and_return imgkit_double
      allow(ImageTemplates::Comment).to receive(:new).and_return template_double
    end

    it 'uses the correct template' do
      described_class.call(template: 'Comment', options: { fake: true })

      expect(ImageTemplates::Comment).to have_received(:new).with(fake: true)
    end

    it 'passes the templates parameters to IMGkit' do
      described_class.call(template: 'Comment')

      expect(IMGKit).to have_received(:new).with(template_double.to_html,
                                                 width: template_double.image_width,
                                                 quality: template_double.image_quality)
    end

    it 'generates a jpg with IMGKit' do
      described_class.call(template: 'Comment')

      expect(imgkit_double).to have_received(:to_img).with(:jpg)
    end
  end
end
