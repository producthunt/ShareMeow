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

    def filename
      "#{self.class.name.demodulize.downcase}/#{Time.now.to_i}#{SecureRandom.hex(4)}.jpg"
    end

    def to_html
      Tilt.new(erb_template).render(render_options)
    end

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
