class Recruiter::SubmissionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :set_submission, only: %i[ show update destroy ]

  def index
    @submissions = Submission.all
    render 'index.json.jbuilder'
  end

  def show
    render 'show.json.jbuilder'
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      render 'create.json.jbuilder'
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::InvalidForeignKey
    render json: { error: "Invalid job_id provided or job does not exist" }, status: :unprocessable_entity
  end

  def update
    if @submission.update(submission_params)
      render 'update.json.jbuilder'
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @submission.destroy
      render json: { message: "Submission successfully deleted" }, status: :ok
    else
      render json: { error: "Failed to delete submission" }, status: :unprocessable_entity
    end
  end

  private
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:email, :mobile_phone, :resume, :job_id)
    end

    def not_found
      render json: { message: 'Submission doesn\'t exist', status: :not_found }
    end
end
