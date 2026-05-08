module Mutations
  module Post
    class UpdatePost < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :title, String, required: true
      argument :body, String, required: true

      type Types::PostType, null: false

      def resolve(id:, title:, body:)
        post = ::Post.find(id)
        post.update!(title: title, body: body)
        post
      end
    end
  end
end
