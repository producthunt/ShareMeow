require 'spec_helper'
require 'image_templates/shared_examples'

RSpec.describe ImageTemplates::ShareSheet do
  default_options = { 'profile_image' => 'https://si0.twimg.com/profile_images/1199277090/Screen_shot_2010-12-26_at_11.31.51_AM_normal.png',
                      'name' => 'William Shakespurr',
                      'rank' => 'Meow',
                      'rank_emoji' => '🥃',
                      'verified' => true }

  let(:image_template) { described_class.new(default_options) }

  describe '#to_html' do
    it 'renders the name' do
      expect(image_template.to_html).to include default_options['name']
    end

    it 'renders the content' do
      expect(image_template.to_html).to include default_options['content']
    end

    it 'sets a default minimum height' do
      expect(image_template.to_html).to include 'min-height: 475px'
    end

    it 'sets min-height if included in options' do
      default_options['min_height'] = '500'
      expect(image_template.to_html).to include 'min-height: 500px'
    end
  end

  describe '#render_options' do
    it 'emojifies the name & content' do
      allow(EmojiHelper).to receive(:emojify).and_call_original

      image_template.render_options

      expect(EmojiHelper).to have_received(:emojify).with(default_options['rank_emoji'])
    end
  end

  it_behaves_like 'an ImageTemplate', default_options
end