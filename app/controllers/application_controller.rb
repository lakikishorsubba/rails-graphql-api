class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? || request.headers["Authorization"].present? }
  before_action :authenticate_user!, unless: :devise_controller?

  def authenticate_user!
    if request.headers["Authorization"].present?
      authenticate_user_from_jwt!
    else
      # Standard Devise session authentication
      # Devise's authenticate_user! will handle it
      super
    end
  end

  private

  def authenticate_user_from_jwt!
    token = request.headers["Authorization"]&.split(" ")&.last

    if token.nil?
      return render json: { error: "Not Authenticated" }, status: 401
    end

    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256")
      @current_user = User.find(decoded[0]["sub"])
    rescue JWT::DecodeError
      render json: { error: "Invalid Token" }, status: 401
    end
  end

  def current_user
    @current_user || super
  end
end
