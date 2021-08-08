require 'rails_helper'

RSpec.describe SessionsController do
  let(:random_user){ build(:random_user) }
  describe "Get new" do
    it "response is success" do
      get :new
      expect(response).to be_successful
    end

    it "render new is success" do
      get :new
      expect(response).to render_template(:new)
    end

    it "status 200 is success" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "Post create" do
    it "Login user is success" do
      user = create(:random_user)
      post :create, params: { email: user.email, password: user.password }
      expect(response).to redirect_to root_path
    end

    it "redirect is success" do
      user = create(:random_user)
      post :create, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(302)
    end

    it "Login user without email is fail" do
      user = create(:random_user)
      post :create, params: { password: user.password }
      expect(response).to render_template(:new)
    end   
    
    it "Login user without password is fail" do
      user = create(:random_user)
      post :create, params: { email: user.email }
      expect(response).to render_template(:new)
    end 
  end
end