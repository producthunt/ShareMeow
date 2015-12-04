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

      options.each do |key, _value|
        expect(render_options.options[key.to_sym]).to_not be_nil
      end
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
