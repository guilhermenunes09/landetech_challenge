require 'rails_helper'

RSpec.describe "ApplicationController", type: :request do
  describe "GET /recruiter/recruiters" do
    it "works! (now write some real specs)" do
      get '/recruiter/recruiters'
      expect(response).to have_http_status(200)
    end
  end

  describe "#encode_token" do
    it "encodes a payload" do
      payload = { recruiter_id: 1 }
      token = ApplicationController.new.encode_token(payload)

      expect(token).not_to be_nil
    end
  end

  describe "#decoded_token" do
    context "with valid token" do
      it "decodes the token" do
        controller = ApplicationController.new
        token = controller.encode_token(recruiter_id: 1)
        allow(controller).to receive(:request).and_return(double(headers: { "Authorization" => "Bearer #{token}" }))

        decoded = controller.decoded_token

        expect(decoded).not_to be_nil
        expect(decoded[0]["recruiter_id"]).to eq(1)
      end
    end

    context "with invalid token" do
      it "returns nil" do
        controller = ApplicationController.new
        allow(controller).to receive(:request).and_return(double(headers: { "Authorization" => "Bearer invalid_token" }))

        decoded = controller.decoded_token

        expect(decoded).to be_nil
      end
    end
  end

  describe "#current_user" do
    before do
      @recruiter = Recruiter.create!(name: "Recruiter 99", email: "recruitermail99@mail.com", password: "123456")
    end

    context "with valid token" do
      it "sets @recruiter" do
        controller = ApplicationController.new

        token = controller.encode_token(recruiter_id: @recruiter.id)
        allow(controller).to receive(:request).and_return(double(headers: { "Authorization" => "Bearer #{token}" }))

        user = controller.current_user

        expect(user).not_to be_nil
        expect(user.id).to eq(@recruiter.id)
      end
    end

    context "with invalid token" do
      it "returns an unauthorized message" do
        get '/recruiter/recruiters'

        expect(JSON.parse(response.body)["message"]).to eq("Not authorized")
      end
    end
  end
end
