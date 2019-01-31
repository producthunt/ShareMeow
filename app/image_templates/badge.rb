module ImageTemplates
  class Badge < Base
    def render_options
      @options['icon'] = @options['icon'] || 'default'
      @options['theme'] = @options['theme'] || 'light-theme'

      super
    end

    def allowed_options
      %w(icon title subtitle upvote_count theme)
    end

    def erb_template
      'app/views/badge.erb'
    end

    def css_stylesheet
      'app/css/badge.css'
    end

    def image_width
      220
    end
  end
end
