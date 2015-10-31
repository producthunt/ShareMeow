module ImageTemplates
  class HelloWorld < Base
    def erb_template
      'app/views/hello_world.erb'
    end

    def image_width
      500
    end
  end
end
