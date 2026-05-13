RSpec.describe "DeletePost Mutation", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:the_post) { create(:post, user: user) }

  let(:mutation) do
    %(
      mutation DeletePost($id: ID!) {
        deletePost(input: { id: $id }) {
          id
          title
        }
      }
    )
  end

  context "when authenticated as a different user" do
    it "returns unauthorized errors" do
      graphql_request(mutation, user: other_user)
      expect(graphql_errors).to be_present
      expect(graphql_error.first["message"]).to eq("Unauthorized")
    end
  end

  context "when authenticated as post owner" do
    it "delete post successully" do
      graphql_request(mutation, user: user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "when not authorized" do
    it "returns unauthorized" do
      graphql_request(mutation, variables: { id: the_post.id })
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
