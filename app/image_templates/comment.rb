module ImageTemplates
  class Comment < Base
    def erb_template
      'app/views/comment.erb'
    end

    def image_width
      300
    end
  end
end
