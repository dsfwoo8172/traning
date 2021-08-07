require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:random_user){ build(:random_user) }
  describe "#new" do
    it "response is success" do
      get :new

      expect(response).to be_successful
      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    it "redirect is success" do
      post :create, params: { user: attributes_for(:random_user) }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end
end