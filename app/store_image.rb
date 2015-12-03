module ShareMeow
  class StoreImage
    BUCKET_NAME = ENV.fetch('AWS_BUCKET_NAME')

    attr_reader :filename, :image_binary_data

    def initialize(filename, image_binary_data)
      @filename = filename
      @image_binary_data = image_binary_data
    end

    def store!
      s3_object.put(body: image_binary_data, content_type: 'image/jpeg'.freeze)
      s3_object.public_url
    end

    private

    def s3_object
      @s3_object ||= Aws::S3::Resource.new.bucket(BUCKET_NAME).object(filename)
    end
  end
end
