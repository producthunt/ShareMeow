module ImageTemplates
  class Badge < Base
    def render_options
      @options['theme'] = @options['theme'] || 'light-theme'

      super
    end

    def allowed_options
      %w(icon title subtitle theme)
    end

    def erb_template
      'app/views/image-embeds/badge.erb'
    end

    def css_stylesheet
      'app/css/image-embeds/badge.css'
    end

    def image_width
      200
    end
  end
end
