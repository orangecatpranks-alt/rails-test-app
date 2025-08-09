# Base controller for all API controllers.
# CSRF protection is skipped because API requests are typically stateless
# and authenticated via tokens (e.g., JWT), not browser sessions.
class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
end
