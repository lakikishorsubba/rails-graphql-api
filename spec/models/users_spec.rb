RSpec.describe User, type: :model do
  # rspec test cases goes here
  it "user to be valid" do
    user = create(:user)
    expect(user).to be_valid
  end
end
