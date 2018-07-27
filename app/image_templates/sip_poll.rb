module ImageTemplates
  class SipPoll < Base
    def render_options
      @options[:poll_options] = percentage_for_css(@options[:poll_options])
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

    private

    def percentage_for_css(poll_options)
      poll_options.map do |poll_option|
        # NOTE (kristian): Kinda hacky approach to some wkhtmltoimage limitations by
        # manually defining an offset percentage for this container
        percentage = if poll_option['percentage'] > 1
          poll_option['percentage'] - 1
        else
          0
        end

        {
          option: poll_option['option'],
          percentage: poll_option['percentage'],
          css_percentage: "#{percentage}%"
        }
      end
    end
  end
end
