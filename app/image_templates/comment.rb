require 'app/emoji_helper'

module ImageTemplates
  class Comment < Base
    def render_options
      @options[:name] = EmojiHelper.emojify(@options[:name])
      @options[:tagline] = EmojiHelper.emojify(@options[:tagline])
      @options[:product_name] = EmojiHelper.emojify(@options[:product_name])
      @options[:product_tagline] = EmojiHelper.emojify(@options[:product_tagline])
      @options[:content] = EmojiHelper.emojify(@options[:content])

      super
    end

    def allowed_options
      %w(content name tagline avatar_url product_name product_tagline)
    end

    def erb_template
      'app/views/comment.erb'
    end

    def css_stylesheet
      'app/css/comment.css'
    end

    def image_width
      450
    end
  end
end
