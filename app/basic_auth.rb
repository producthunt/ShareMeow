class BasicAuth < Rack::Auth::Basic
  PROTECTED_PATHS = ['/image', '/image/inline']

  def call(env)
    request = Rack::Request.new(env)

    return super if PROTECTED_PATHS.include? request.path

    @app.call(env)
  end
end
