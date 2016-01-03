require 'app/emoji_helper'

module ImageTemplates
  class Comment < Base
    def render_options
      @options[:name] = EmojiHelper.emojify(@options[:name])
      @options[:subject_name] = truncate_text(@options[:subject_name], 35)
      @options[:subject_name] = EmojiHelper.emojify(":speech_balloon: on #{@options[:subject_name]}")
      @options[:content] = EmojiHelper.emojify(@options[:content])

      super
    end

    def allowed_options
      %w(content name user_id subject_name min_height)
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

    private

    def truncate_text(text, max_length)
      return text unless text.length > max_length
      text[0..max_length].gsub(/\s\w+\s*$/, '...')
    end
  end
end
