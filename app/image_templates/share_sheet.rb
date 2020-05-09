module ImageTemplates
  class ShareSheet < Base
    def render_options
      @options[:rank_emoji] = EmojiHelper.emojify(@options[:rank_emoji])
      # @options[:poll_options] = @options[:poll_options].map do |option|
      #   option.merge('option': EmojiHelper.emojify(option['option'], strip: true))
      # end
      super
    end

    def allowed_options
      %w(name rank_emoji rank profile_image verified)
    end

    def erb_template
      'app/views/share_sheet.erb'
    end

    def css_stylesheet
      'app/css/share_sheet.css'
    end

    def image_width
      450
    end
  end
end
