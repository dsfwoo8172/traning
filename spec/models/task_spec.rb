require 'rails_helper'

RSpec.describe Task, type: :model do
  
  describe "Associations" do
    it { should belong_to(:user) }
  end

  subject {
    described_class.new(title: "Anything",
                        start_time: DateTime.now,
                        end_time: DateTime.now + 1.week,
                        order: "low",
                        state: "pending",
                        user_id: 1
                        )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  
    it "is not valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid  
    end
  
    it "is not valid without start time" do
      subject.start_time = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without end time" do
      subject.end_time = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without order" do
      subject.order = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without state" do
      subject.state = nil
      expect(subject).to_not be_valid
    end
  end
end
