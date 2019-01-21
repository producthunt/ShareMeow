module ImageTemplates
  class FeaturedOn < Base
    def render_options
      @options['text'] = @options['text'] || 'Find us'

      super
    end

    def allowed_options
      %w(text upvote_count)
    end

    def erb_template
      'app/views/image-embeds/featured_on.erb'
    end

    def css_stylesheet
      'app/css/image-embeds/featured_on.css'
    end

    def image_width
      255
    end
  end
end
