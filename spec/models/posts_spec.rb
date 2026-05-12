require 'rails_helper'

RSpec.describe Post, type: :model do
  it "post to be valid" do
    post  = create(:post)
    expect(post).to be_valid
  end
end
