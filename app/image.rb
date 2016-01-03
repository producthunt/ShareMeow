require 'securerandom'

module ShareMeow
  class Image
    # Zooming in makes text more crisp
    DEFAULT_OPTIONS = { zoom: 2 }

    attr_reader :template

    def initialize(params)
      @template = template_class(params['template']).send(:new, params)
    end

    def to_jpg
      options = DEFAULT_OPTIONS.merge(width: template.image_width, quality: template.image_quality)

      image_kit = IMGKit.new(template.to_html, options)
      image_kit.stylesheets << template.css_stylesheet

      image_kit.to_img(:jpg)
    end

    private

    def template_class(template_name)
      ImageTemplates.const_get template_name
    rescue NameError
      raise NotImplementedError, "You must implement a #{template_name} template"
    end
  end
end
