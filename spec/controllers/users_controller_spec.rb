require 'rails_helper'

RSpec.describe UsersController do
  let(:user){ create(:random_user) }

  describe "Get edit" do

    before do
      login(user)
      get :edit
    end

    it "redner edit" do
      expect(response).to render_template(:edit)
    end

    it "http status 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "Patch update" do

    before do
      login(user)
      @user = User.find(user.id)
      patch :update, params: { id: @user.id, user: {password: '222222', password_confirmation: '222222'} }
    end

    it "same user" do
      expect(assigns[:user]).to eq(@user)
    end

    it "change value" do
      expect(assigns[:user].password).to eq('222222')
    end

    it "redirect to root" do
      expect(response).to redirect_to root_path
    end
  end

end