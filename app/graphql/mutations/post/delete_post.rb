module Mutations
  module Post
    class DeletePost < Mutations::BaseMutation
      argument :id, ID, required: true
      # argument :title, String, required: true
      # argument :body, String, required: true
      type Types::PostType, null: false

      def resolve(id:)
        post = ::Post.find(id)
        post.destroy!
        post
      end
    end
  end
end
