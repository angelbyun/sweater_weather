class Api::V1::SessionsController < ApplicationController
  # rescue_from ActiveRecord::RecordInvalid, with: :render_not_found_response
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # def render_not_found_response(error)
  #   render json: ErrorSerializer.new(error), status: 404
  # end

  # def render_invalid_response(error)
  #   render json: ErrorSerializer.new(error), status: 400
  # end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: { error: 'Invalid input - please try again!' }, status: 400
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end