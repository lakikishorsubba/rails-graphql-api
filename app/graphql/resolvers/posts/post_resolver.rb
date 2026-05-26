module Resolvers
  module Posts
    class PostResolver < Resolvers::BaseResolver
      argument :id, ID, required: true
      type Types::PostType, null: false

      def resolve(id:)
        post = ::Post.find_by(id: id)

        if post.nil?
          raise ::NotFoundError, "Post with id #{id} not found "
        end
        post
      end
    end
  end
end
