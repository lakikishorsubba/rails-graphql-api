RSpec.describe(User, type: :model) do # just for redable
  # rspec test cases goes here
  it("is user to be valid") do
    user = create(:user)
    expect(user).to be_valid # does user.valid?
  end

  it("is invalid without email") do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it("is invalid with duplicate email") do
    create(:user, email: "test@gmail.com")
    user = build(:user, email: "test@gmail.com")

    expect(user).not_to be_valid
  end
end
