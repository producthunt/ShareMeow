require 'spec_helper'

RSpec.describe EmojiHelper do
  describe '.emojify' do
    it 'turns unicode into emoji' do
      content = described_class.emojify('My emoji content 😀')

      expect(content).to eq "My emoji content <img alt=\"grinning\" " \
                            "src=\"#{ShareMeow::App.base_url}/images/emoji/unicode/1f600.png\" " \
                            "style=\"vertical-align:middle\" width=\"20\" height=\"20\" />"
    end

    it 'converts GitHub/Slack style emoji' do
      content = described_class.emojify(':smiley:')

      expect(content).to eq "<img alt=\"smiley\" src=\"#{ShareMeow::App.base_url}/images/emoji/unicode/1f603.png\" " \
                            "style=\"vertical-align:middle\" width=\"20\" height=\"20\" />"
    end

    it 'does not replace unsupported emoji' do
      content = described_class.emojify(':producthunt_kitty:')

      expect(content).to eq ':producthunt_kitty:'
    end
  end
end
