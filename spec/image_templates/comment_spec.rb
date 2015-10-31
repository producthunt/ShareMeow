require 'spec_helper'
require 'image_templates/shared_examples'

RSpec.describe ImageTemplates::Comment do
  default_options = { name: 'William Shakespurr', tagline: 'Official Spokescat of ProductHunt Books', content: 'Meow' }

  let(:image_template) { described_class.new(default_options) }

  describe '#to_html' do
    it 'renders the name' do
      expect(image_template.to_html).to include default_options[:name]
    end

    it 'renders the tagline' do
      expect(image_template.to_html).to include default_options[:tagline]
    end

    it 'renders the comment contents' do
      expect(image_template.to_html).to include default_options[:content]
    end
  end

  it_behaves_like 'an ImageTemplate', default_options
end
