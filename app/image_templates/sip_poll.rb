module ImageTemplates
  class SipPoll < Base
    def render_options
      @options[:poll_question] = EmojiHelper.emojify(@options[:poll_question])
      @options[:poll_options] = @options[:poll_options].map do |option|
        option.merge({ 'option': EmojiHelper.emojify(option['option'], strip: true) })
      end
      super
    end

    def allowed_options
      %w[poll_question poll_options thumbnail_uuid]
    end

    def erb_template
      'app/views/sip_poll.erb'
    end

    def css_stylesheet
      'app/css/sip_poll.css'
    end

    def image_width
      450
    end
  end
end
