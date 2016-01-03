require 'tilt'
require 'imgkit'

module ImageTemplates
  class Base
    RenderOptions = Struct.new(:options)

    def initialize(options = {})
      @options = options.slice(*allowed_options).symbolize_keys
    end

    def render_options
      @render_options ||= RenderOptions.new(@options)
    end

    def to_html
      Tilt.new(erb_template).render(render_options)
    end

    ##
    # Keys for the options we allow to be passed to the ERB template
    #
    # == Example
    #   def allowed_options
    #     %w(message content name)
    #   end
    #
    # Would make `options[:message]`, `options[:content]` and `options[:name]` available
    # in the ERB template.
    #
    # @return [Array]
    #
    # @api public
    def allowed_options
      fail NotImplementedError, "You must specify allowed_options for your #{self.class.name} template."
    end

    def erb_template
      fail NotImplementedError, "You must specify an erb_template for your #{self.class.name} template."
    end

    def image_quality
      100
    end

    def image_width
      # optional
    end

    def css_stylesheet
      'app/css/default.css'
    end
  end
end
