require 'rails_helper'

RSpec.describe "Recruiter::JobsController", type: :request do
  include_context "recruiter setup"

  describe "#INDEX" do
    it "successfully retrieves jobs" do
      get recruiter_jobs_path

      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new job" do
        valid_params = { job: { title: "Software Engineer", description: "Description", recruiter_id: 1 } }

        expect {
          post recruiter_jobs_path, params: valid_params
        }.to change(Job, :count).by(1)

        expect(response).to have_http_status(200)
      end
    end

    context "when invalid job parameters are provided" do
      it "with invalid params" do
        invalid_params = { job: { title: "", description: "", recruiter_id: 1 } }

        post recruiter_jobs_path, params: invalid_params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["title"]).to include("can't be blank")
        expect(JSON.parse(response.body)["description"]).to include("can't be blank")
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      it "updates the job" do
        job = Job.create(title: "Existing Job", description: "Old job description", recruiter_id: 1)
        valid_params = { job: { description: "Updated job description" } }

        put recruiter_job_path(job), params: valid_params

        expect(response).to have_http_status(200)
      end
    end
  end

  context "with invalid" do
    it "returns an error message" do
      job = Job.create(title: "Existing Job", description: "Old job description", recruiter_id: 1)
      invalid_params = { job: { title: "", description: "" } }

      put recruiter_job_path(job), params: invalid_params

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["title"]).to include("can't be blank")
      expect(JSON.parse(response.body)["description"]).to include("can't be blank")
    end
  end

  describe "#destroy" do
    it "deletes the job" do
      job = Job.create(title: "Existing Job", description: "Old job description", recruiter_id: 1)

      expect {
        delete recruiter_job_path(job)
      }.to change(Job, :count).by(-1)

      expect(response).to have_http_status(200)
    end
  end
end
