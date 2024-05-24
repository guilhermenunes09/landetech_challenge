require 'rails_helper'

RSpec.describe "Recruiter::SubmissionsController", type: :request do
  include_context "recruiter setup"

  describe "#index" do
    it "should get all submissions" do
      get recruiter_submissions_path
      expect(response).to have_http_status(200)

      expect(response.body).to include("example1@example.com")
      expect(response.body).to include("example2@example.com")
      expect(response.body).to include("example3@example.com")
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new submission" do
        valid_params = { submission: { email: "new@example.com", job_id: 1 } }

        expect {
          post recruiter_submissions_path, params: valid_params
        }.to change(Submission, :count).by(1)

        expect(response).to have_http_status(200)
      end
    end

    context "with invalid job_id" do
      it "returns an error message" do
        invalid_params = { submission: { email: "new@example.com", job_id: 999 } }

        post recruiter_submissions_path, params: invalid_params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["error"]).to eq("Invalid job_id provided or job does not exist")
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      it "updates the submission" do
        submission = Submission.create(email: "existing@example.com", job_id: 1)
        valid_params = { submission: { email: "updated@example.com" } }

        put recruiter_submission_path(submission), params: valid_params

        expect(response).to have_http_status(200)
      end
    end

    context "with invalid params" do
      it "returns an error message" do
        submission = Submission.create(email: "existing2@example.com", job_id: 1)
        invalid_params = { submission: { email: "" } }

        put recruiter_submission_path(submission), params: invalid_params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["email"]).to include("can't be blank")
      end
    end

    describe "#destroy" do
      it "deletes the submission" do
        submission = Submission.create(email: "existing@example.com", job_id: 1)

        expect {
          delete recruiter_submission_path(submission)
        }.to change(Submission, :count).by(-1)

        expect(response).to have_http_status(200)
      end
    end
  end
end
