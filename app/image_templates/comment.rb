require 'app/emoji_helper'

module ImageTemplates
  class Comment < Base
    def render_options
      @options[:name] = EmojiHelper.emojify(@options[:name])
      @options[:tagline] = EmojiHelper.emojify(@options[:tagline])
      @options[:content] = EmojiHelper.emojify(@options[:content])

      super
    end

    def allowed_options
      %w(content name tagline avatar_url)
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
