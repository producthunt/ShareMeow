require 'tilt'
require 'imgkit'

module ImageTemplates
  class Base
    RenderOptions = Struct.new(:options)

    attr_reader :options

    def initialize(options = {})
      @options = RenderOptions.new(options)
    end

    def to_html
      Tilt.new(erb_template).render(options)
    end

    def erb_template
      fail NotImplementedError, "You must specify an erb_template for your #{this.class.name} template."
    end

    def image_quality
      100
    end

    def image_width
      # optional
    end

    def css_file
      # optional
    end
  end
end
