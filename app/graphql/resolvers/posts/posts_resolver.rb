# module Resolvers
#   module Posts
#     class PostsResolver < Resolvers::BaseResolver
#       # return type
#       type Types::PostType.connection_type, null: false
#       # field arguement that client can pass in the query or filtering
#       argument :status, Types::PostStatusType, required: false
#       argument :author_id, ID, required: false
#       argument :title, String, required: false
#       argument :body, String, required: false

#       # no query object, cant reuse, cant scale

#       # def resolve(status: nil, author_id: nil, title: nil, body: nil, **args) # collect all arguement into a ruby hash
#       #   # return  ::Post.all.order(created_at: :asc)
#       #   posts = ::Post.all.order(created_at: :asc)
#       #   # conditonal filtering
#       #   if status.present?
#       #     posts = posts.where(status: status)
#       #   end

#       #   if author_id.present?
#       #     posts = posts.where(user_id: author_id)
#       #   end
#       #   if title.present?
#       #     posts = posts.where("title ILIKE ?", "%#{title}%")
#       #   end

#       #   if body.present?
#       #     posts = posts.where("body ILIKE ?", "%#{body}%")
#       #   end
#       #   posts
#       # end

#       def resolve(**args) # combines all arguement into ruby hash, whaterver this function returns it gets paginated
#         local_posts  = PostsQuery.new(params: args).run.to_a # pss params as args hash
#         external_posts = faraday_posts

#         local_posts + external_posts
#       end

#       private
#       # actual external post fetch.
#       def faraday_posts
#         # blocks that can be call or used later in anotehr func
#         PostsFaradayServices.new.fetch_all.map do |item| # .iterate over each array of hash
#           # iterate over each and create new unsave post with clear query fields
#           post = Post.new( # keyword arguement
#             id: item["id"],
#             title: item["title"], # reads the hash value and assign, same as ruby hash access
#             body: item["body"],
#             status: :published,
#             created_at: 1.months.from_now,
#             updated_at: 1.months.from_now
#           )
#           post
#         end
#       rescue Faraday::Error =>e
#         Rails.logger.warn("Faraday is down: #{e}")
#         # or simply raise e
#       end
#     end
#   end
# end

module Resolvers
  module Posts
    class PostsResolver < Resolvers::BaseResolver
      type Types::PostType.connection_type, null: false

      argument :status,    Types::PostStatusType, required: false
      argument :author_id, ID,                    required: false
      argument :title,     String,                required: false
      argument :body,      String,                required: false

      def resolve(**args)
        PostsQuery.new(params: args).run
      end
    end
  end
end
