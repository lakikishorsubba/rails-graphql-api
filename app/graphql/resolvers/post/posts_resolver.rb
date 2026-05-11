module Resolvers
  module Post
    class PostsResolver < Resolvers::BaseResolver
      type Types::PostType.connection_type, null: false
      argument :status, Types::PostStatusType, required: false
      argument :author_id, ID, required: false
      argument :title, String, required: false
      argument :body, String, required: false

      def resolve(**args)
        ::PostsQuery.new(params: args, skip: args[:skip]).run
      end
    end
  end
end
