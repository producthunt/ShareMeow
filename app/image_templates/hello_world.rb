module ImageTemplates
  class HelloWorld < Base
    def allowed_options
      ['message']
    end

    def erb_template
      'app/views/hello_world.erb'
    end

    def css_stylesheet
      'app/css/hello_world.css'
    end

    def image_width
      500
    end
  end
end
