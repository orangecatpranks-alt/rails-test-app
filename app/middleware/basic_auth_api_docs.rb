# frozen_string_literal: true

class BasicAuthApiDocs
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    if protected_path?(req.path_info)
      auth = Rack::Auth::Basic.new(@app, "API Documentation") do |username, password|
        authenticate_user(username, password)
      end
      auth.call(env)
    else
      @app.call(env)
    end
  end

  private

  def protected_path?(path)
    path.start_with?("/api-docs")
  end

  def authenticate_user(username, password)
    expected_username = Rails.application.credentials.dig(:swagger, :user) ||
      raise("swagger.user is missing from credentials")

    expected_password = Rails.application.credentials.dig(:swagger, :pass) ||
      raise("swagger.pass is missing from credentials")

    ActiveSupport::SecurityUtils.secure_compare(username.to_s, expected_username.to_s) &&
      ActiveSupport::SecurityUtils.secure_compare(password.to_s, expected_password.to_s)
  end
end
