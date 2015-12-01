require 'securerandom'
require 'app/store_image'

module ShareMeow
  class Image
    # Zooming in makes text more crisp
    DEFAULT_OPTIONS = { zoom: 2 }

    attr_reader :template

    def initialize(params)
      @template = template_klass(params[:template]).send(:new, params)
    end

    def generate_and_store!
      ShareMeow::StoreImage.new(template.filename, generate_jpg).store!
    end

    private

    def s3_object
      @s3_object ||= Aws::S3::Resource.new.bucket('sharemeow').object(template.filename)
    end

    def generate_jpg
      options = DEFAULT_OPTIONS.merge(width: template.image_width, quality: template.image_quality)

      image_kit = IMGKit.new(template.to_html, options)
      image_kit.stylesheets << template.css_stylesheet

      image_kit.to_img(:jpg)
    end

    def template_klass(template_name)
      ImageTemplates.const_get template_name
    rescue NameError
      raise NotImplementedError, "You must implement a #{template_name} template"
    end
  end
end
