module EmojiHelper
  IMAGE_PARAMS = %(style="vertical-align:middle" width="20" height="20")

  def self.emojify(content, strip: false)
    content = Rumoji.encode(content)

    content.to_str.gsub(/:([\w+-]+):/) do |match|
      emoji = Emoji.find_by_alias(Regexp.last_match(1))

      if emoji
        %(<img alt="#{Regexp.last_match(1)}" src="#{ShareMeow::App.base_url}/images/emoji/#{emoji.image_filename}" #{IMAGE_PARAMS} />)
      else
        strip ? nil : match
      end
    end
  end
end
