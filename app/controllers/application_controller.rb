class ApplicationController < ActionController::API
  before_action :authenticate_api_key!

	private

  def authenticate_api_key!
    api_key = request.headers['X-API-Key']
    @current_user = User.find_by(api_key: api_key)

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

end
