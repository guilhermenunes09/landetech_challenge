require 'rails_helper'

RSpec.describe "AuthController", type: :request do
  describe "#login" do
    context "with valid email and password" do
      it "returns a token" do
        recruiter = Recruiter.create(name: "Test Recruiter", email: "test@example.com", password: "password")

        post auth_login_path, params: { email: "test@example.com", password: "password" }

        expect(JSON.parse(response.body)["token"]).not_to be_nil
      end
    end

    context "with invalid email or password" do
      it "returns an unauthorized message" do
        post auth_login_path, params: { email: "invalid@example.com", password: "wrong_password" }
        puts response.body
        expect(JSON.parse(response.body)["message"]).to eq("Email and password doesn't match")
      end
    end

    context "when user does not exist" do
      it "returns an unauthorized message" do
        post auth_login_path, params: { email: "nonexistent@example.com", password: "password" }

        expect(JSON.parse(response.body)["message"]).to eq("Email and password doesn't match")
      end
    end
  end
end
