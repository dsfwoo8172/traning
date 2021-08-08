require 'rails_helper'

RSpec.describe RegistrationsController do
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
    it "Create user is success" do
      expect { post :create, params: { user: attributes_for(:random_user) } }.to change(User, :count).by(1)
    end

    it "Create user without email is fail" do
      expect { post :create, params: { user: {password: random_user.password, password_confirmation: random_user.password} } }.to change(User, :count).by(0)
    end

    it "render new without email when create user" do
      post :create, params: { user: {password: random_user.password, password_confirmation: random_user.password} }
      expect(response).to render_template(:new)
    end

    it "Create user without password is fail" do
      expect { post :create, params: { user: {email: random_user.email, password_confirmation: random_user.password} } }.to change(User, :count).by(0)
    end

    it "render new without password when create user" do
      post :create, params: { user: {email: random_user.email, password_confirmation: random_user.password} }
      expect(response).to render_template(:new)
    end

    it "Create user without password confirmation is fail" do
      expect { post :create, params: { user: {email: random_user.email, password: random_user.password} } }.to change(User, :count).by(0)
    end

    it "render new without password confirmation when create user" do
      post :create, params: { user: {email: random_user.email, password: random_user.password} }
      expect(response).to render_template(:new)
    end

    it "redirect is success" do
      post :create, params: { user: attributes_for(:random_user) }
      expect(response).to redirect_to root_path
    end
  end
end