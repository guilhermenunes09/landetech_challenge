class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :recruiter_not_found
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 'encode_string')
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(" ")[1]

      begin
        JWT.decode(token, 'encode_string')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      recruiter_id = decoded_token[0]['recruiter_id']

      begin
        @recruiter = Recruiter.find(recruiter_id)
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Not found', status: :unauthorized }
      end
    end
  end

  def authorized
    unless current_user.present?
      render json: { message: 'Not authorized', status: :unauthorized }
    end
  end
end
