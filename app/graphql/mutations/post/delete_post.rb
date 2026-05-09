module Mutations
  module Post
    class DeletePost < Mutations::BaseMutation
      argument :id, ID, required: true
      # argument :title, String, required: true
      # argument :body, String, required: true
      type Types::PostType, null: false

      def resolve(id:)
        post = ::Post.find_by(id: id)

       if post # truthy value
          post.destroy!
          post
       else
          raise ::NotFoundError, "Post with id #{id} not found"
       end
      end
    end
  end
end
