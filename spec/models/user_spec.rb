require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:tasks) }
  end
  subject { 
    described_class.new(
                        password: "111111", 
                        password_confirmation: "111111",
                        email: "sid@gmail.com"
                      )  
  }
  describe "Validations" do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end
end
