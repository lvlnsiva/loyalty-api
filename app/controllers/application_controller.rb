class ApplicationController < ActionController::API
  before_action :authenticate_api_key!

	private

  def authenticate_api_key!
    api_key = request.headers['X-API-Key']
    @current_user = User.find_by(api_key: api_key)

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def render_success(data = {}, message: 'Success', code: 200, status: :ok)
    render json: {
      code: 200,
      message: message,
      data: data,
    }, status: :ok
  end

  def render_error(http_status, code:, error_message:)
    render json: {
      code: code,
      message: error_message
    }
  end

end
