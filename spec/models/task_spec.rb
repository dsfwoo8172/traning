require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user){ create(:user) }
  let(:task){ build(:task) }

  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:priority) }

    it "is valid with valid attributes" do
      task.user_id = user.id
      expect(task).to be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:user) }
  end
end
