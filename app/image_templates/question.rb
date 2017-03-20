require 'app/emoji_helper'

module ImageTemplates
  class Question < Base
    def render_options
      @options[:name] = EmojiHelper.emojify(@options[:name])
      @options[:content] = EmojiHelper.emojify(@options[:content])

      super
    end

    def allowed_options
      %w(content name user_id min_height)
    end

    def erb_template
      'app/views/question.erb'
    end

    def css_stylesheet
      'app/css/question.css'
    end

    def image_width
      450
    end
  end
end
