class Recruiter::RecruitersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  skip_before_action :authorized, only: [:create]
  before_action :set_recruiter, only: %i[ show edit update destroy ]

  def index
    @recruiters = Recruiter.all
    render 'index.json.jbuilder'
  end

  def show
    render 'show.json.jbuilder'
  end

  def create
    @recruiter = Recruiter.new(recruiter_params)

    if @recruiter.save
      @token = encode_token(recruiter_id: @recruiter.id)

      render 'create.json.jbuilder'
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recruiter.update(recruiter_params)
      render 'update.json.jbuilder'
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @recruiter.destroy
      render json: { message: "Recruiter successfully deleted" }, status: :ok
    else
      render json: { error: "Failed to delete recruiter" }, status: :unprocessable_entity
    end
  end

  private
    def set_recruiter
      @recruiter = Recruiter.find(params[:id])
    end

    def recruiter_params
      params.require(:recruiter).permit(:name, :email, :password, :password_confirmation)
    end

    def not_found
      render json: { message: 'Recruiter doesn\'t exist', status: :not_found }
    end
end
