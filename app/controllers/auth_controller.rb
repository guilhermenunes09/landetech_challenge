class AuthController < ApplicationController
  skip_before_action :authorized, only: [:login]
  rescue_from ActiveRecord::RecordNotFound, with: :login_failed

  def login
    @recruiter = Recruiter.find_by!(email: login_params[:email])

    if @recruiter.authenticate(login_params[:password])
      @token = encode_token(recruiter_id: @recruiter.id)
      render 'login.json.jbuilder'
    else
      render json: { message: 'Email and password doesn\'t match', status: :unauthorized }
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def login_failed
    render json: { message: 'Email and password doesn\'t match', status: :unauthorized }
  end
end
