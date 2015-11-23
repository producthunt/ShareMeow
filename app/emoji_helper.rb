module EmojiHelper
  def self.emojify(content)
    content = Rumoji.encode(content)

    content.to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="http://localhost:3000/images/emoji/#{emoji.image_filename}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end
  end
end
