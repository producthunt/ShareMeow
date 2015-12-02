RSpec.shared_examples 'an ImageTemplate' do |options|
  let(:image_template) { described_class.new(options) }

  describe '#to_html' do
    it 'renders a String' do
      expect(image_template.to_html).to be_a String
    end
  end

  describe '#render_options' do
    it 'returns an object containing the options needed by the erb template' do
      render_options = image_template.render_options

      options.each do |key, value|
        expect(render_options.options[key.to_sym]).to eq value
      end
    end
  end

  describe '#template_name' do
    it 'returns the template name' do
      expect(image_template.template_name).to eq described_class.name.demodulize.downcase
    end
  end

  describe '#cache_key' do
    it 'includes template name' do
      expect(image_template.cache_key).to start_with("#{image_template.template_name}/")
    end

    it 'changes with different options' do
      cache_key = described_class.new(options).cache_key

      options[options.first[0]] = 'Changing value to something else'
      other_key = described_class.new(options).cache_key

      expect(cache_key).to_not eq other_key
    end

    it 'includes the image template files in the key' do
      digest_double = instance_double(Digest::SHA1, file: true, hexdigest: 'fake')

      allow(Digest::SHA1).to receive(:new).and_return digest_double
      allow(digest_double).to receive(:file).and_return true

      image_template.cache_key

      expect(digest_double).to have_received(:file).with(image_template.erb_template)
      expect(digest_double).to have_received(:file).with(image_template.css_stylesheet)
      expect(digest_double).to have_received(:file).with(image_template.method(:allowed_options).source_location.first)
    end
  end

  describe '#filename' do
    it 'return a jpg filename' do
      expect(image_template.filename).to end_with('.jpg')
    end

    it 'includes template name' do
      expect(image_template.filename).to start_with("#{image_template.template_name}/")
    end
  end

  describe '#erb_template' do
    it 'is a valid file' do
      expect(File).to exist(image_template.erb_template)
    end
  end

  describe '#css_stylesheet' do
    it 'is a valid file' do
      expect(File).to exist(image_template.css_stylesheet)
    end
  end

  describe '#image_quality' do
    it 'is a valid #' do
      expect(image_template.image_quality).to be_an Integer
      expect(image_template.image_quality).to be <= 100
      expect(image_template.image_quality).to be > 0
    end
  end
end
