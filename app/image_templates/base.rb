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
      "#{template_name}/#{Time.now.to_i}#{SecureRandom.hex(4)}.jpg"
    end

    def template_name
      @template_name ||= self.class.name.demodulize.downcase
    end

    def to_html
      Tilt.new(erb_template).render(render_options)
    end

    ##
    # Generates the cache key for the current template.
    #
    #  The cache key is made up of a checksum of all the files used to generate the image
    #  as well as the options used. If any of the files are changed, the cache is broken.
    #  This way we do not need to clear cache between deploys.
    #
    #   Creates a checksum of:
    #     + ImageTemplates::Base
    #     + The current template
    #     + Current templates erb
    #     + Current templates stylesheet
    #     + All options passed to the template
    #
    # @return [String] image template cache_key
    #
    # @api public
    def cache_key
      return @cache_key if @cache_key

      digest = Digest::SHA1.new

      digest.file(File.expand_path(__FILE__))
      digest.file(current_file_location)
      digest.file(erb_template)
      digest.file(css_stylesheet)

      @cache_key = "#{template_name}/#{digest.hexdigest}/#{digest.hexdigest(@options.to_json)}"
    end

    ##
    # Keys for the options we allow to be passed to the ERB template
    #
    # == Example
    #   def allowed_options
    #     ['message', 'content', 'name']
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

    def current_file_location
      method(:allowed_options).source_location.first
    end
  end
end
