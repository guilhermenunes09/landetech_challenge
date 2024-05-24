require 'rails_helper'

RSpec.describe "Recruiter::RecruitersController", type: :request do
  include_context "recruiter setup"

  describe "#index" do
    it "successfully retrieves recruiters" do
      get recruiter_recruiters_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new recruiter" do
        valid_params = { recruiter: { name: "New Recruiter", email: "new@example.com", password: "password", password_confirmation: "password" } }

        expect {
          post recruiter_recruiters_path, params: valid_params
        }.to change(Recruiter, :count).by(1)

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#show" do
    context "when recruiter does not exist" do
      it "returns a not found message" do
        get recruiter_recruiter_path(999)

        expect(JSON.parse(response.body)["message"]).to eq("Recruiter doesn't exist")
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      it "updates the recruiter" do
        new_name = "Updated Recruiter"
        recruiter = Recruiter.create(name: "Existing Recruiter", email: "existing@example.com", password: "password", password_confirmation: "password")
        valid_params = { recruiter: { name: new_name } }

        put recruiter_recruiter_path(recruiter), params: valid_params

        expect(JSON.parse(response.body)["name"]).to eq(new_name)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#destroy" do
    it "deletes the recruiter" do
      recruiter = Recruiter.create(name: "Existing Recruiter", email: "existing@example.com", password: "password", password_confirmation: "password")

      expect {
        delete recruiter_recruiter_path(recruiter)
      }.to change(Recruiter, :count).by(-1)

      expect(response).to have_http_status(200)
    end
  end
end
