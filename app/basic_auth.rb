class BasicAuth < Rack::Auth::Basic
  PROTECTED_PATHS = ['/images']

  def call(env)
    request = Rack::Request.new(env)

    return super if PROTECTED_PATHS.include? request.path

    @app.call(env)  # skip auth
  end
end
