require 'rails_helper'

RSpec.describe User do
  describe "Associations" do
    it { should have_many(:tasks) }
  end
  let(:user){ build(:user) }
  let(:admin){ create(:user) }

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end
  end
  
  describe "test admin method" do
    it "result must be true" do
      expect(admin.admin?).to eq(true)
    end
  end
end
