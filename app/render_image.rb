module ShareMeow
  module RenderImage
    def self.call(template:, options: {})
      template_klass = ImageTemplates.const_get template
      fail NotImplementedError, "You must implement a #{template} template" if template_klass.nil?

      template = template_klass.send(:new, options)
      image_kit = IMGKit.new(template.to_html, width: template.image_width, quality: template.image_quality)
      image_kit.to_img(:jpg)
    end
  end
end
