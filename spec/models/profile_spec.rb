RSpec.describe Profile do
  describe "Associations" do
    it { should belong_to(:user) }
  end
end