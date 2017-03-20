require 'spec_helper'
require 'image_templates/shared_examples'

RSpec.describe ImageTemplates::Question do
  default_options = { 'user_id' => '787',
                      'name' => 'William Shakespurr',
                      'content' => 'Meow' }

  let(:image_template) { described_class.new(default_options) }

  describe '#to_html' do
    it 'renders the name' do
      expect(image_template.to_html).to include default_options['name']
    end

    it 'renders the content' do
      expect(image_template.to_html).to include default_options['content']
    end

    it 'sets a default minimum height' do
      expect(image_template.to_html).to include 'min-height: 75px'
    end

    it 'sets min-height if included in options' do
      default_options['min_height'] = '400'
      expect(image_template.to_html).to include 'min-height: 400px'
    end
  end

  describe '#render_options' do
    it 'emojifies the name & content' do
      allow(EmojiHelper).to receive(:emojify).and_call_original

      image_template.render_options

      expect(EmojiHelper).to have_received(:emojify).with(default_options['name'])
      expect(EmojiHelper).to have_received(:emojify).with(default_options['content'])
    end
  end

  it_behaves_like 'an ImageTemplate', default_options
end
