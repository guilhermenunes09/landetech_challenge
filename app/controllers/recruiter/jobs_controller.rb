class Recruiter::JobsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :set_job, only: %i[ show update destroy ]

  def index
    search = params[:search]

    # optmized for sqlite3
    if search.present?
      sanitized_search = "%#{ActiveRecord::Base.sanitize_sql_like(search)}%"

      @jobs = Job.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ? OR LOWER(skills) LIKE ?",
                        sanitized_search.downcase,
                        sanitized_search.downcase,
                        sanitized_search.downcase)
    else
      @jobs = Job.all
    end

    render 'index.json.jbuilder'
  end

  def show
    render 'show.json.jbuilder'
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      render 'create.json.jbuilder'
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render 'update.json.jbuilder'
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @job.destroy
      render json: { message: "Job successfully deleted" }, status: :ok
    else
      render json: { error: "Failed to delete job" }, status: :unprocessable_entity
    end
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :description, :start_date, :end_date, :status, :skills, :string, :recruiter_id)
    end

    def not_found
      render json: { message: 'Job doesn\'t exist', status: :not_found }
    end
end
