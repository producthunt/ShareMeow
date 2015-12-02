require 'spec_helper'
require 'image_templates/shared_examples'

RSpec.describe ImageTemplates::Comment do
  default_options = { 'avatar_url' => 'https://ph-avatars.imgix.net/787/original?w=80&h=80',
                      'name' => 'William Shakespurr',
                      'tagline' => 'Official Spokescat of ProductHunt Books',
                      'content' => 'Meow',
                      'product_name' => 'Product Hunt Podcasts',
                      'product_tagline' => 'The best new podcasts, every day' }

  let(:image_template) { described_class.new(default_options) }

  describe '#to_html' do
    it 'renders the name' do
      expect(image_template.to_html).to include default_options['name']
    end

    it 'renders the tagline' do
      expect(image_template.to_html).to include default_options['tagline']
    end

    it 'renders the product name' do
      expect(image_template.to_html).to include default_options['product_name']
    end

    it 'renders the product tagline' do
      expect(image_template.to_html).to include default_options['product_tagline']
    end

    it 'renders the comment contents' do
      expect(image_template.to_html).to include default_options['content']
    end
  end

  describe '#render_options' do
    it 'emojifies the name, tagline & content' do
      allow(EmojiHelper).to receive(:emojify).and_call_original

      image_template.render_options

      expect(EmojiHelper).to have_received(:emojify).with(default_options['name'])
      expect(EmojiHelper).to have_received(:emojify).with(default_options['tagline'])
      expect(EmojiHelper).to have_received(:emojify).with(default_options['content'])
    end
  end

  it_behaves_like 'an ImageTemplate', default_options
end
