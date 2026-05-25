module Resolvers
  module Post
    class PostsResolver < Resolvers::BaseResolver
      type Types::PostType.connection_type, null: false
      argument :status, Types::PostStatusType, required: false
      argument :author_id, ID, required: false
      argument :title, String, required: false
      argument :body, String, required: false

      # no query object, cant reuse, cant scale

      # def resolve(status: nil, author_id: nil, title: nil, body: nil, **args) # collect all arguement into a ruby hash
      #   # return  ::Post.all.order(created_at: :asc)
      #   posts = ::Post.all.order(created_at: :asc)
      #   # conditonal filtering
      #   if status.present?
      #     posts = posts.where(status: status)
      #   end

      #   if author_id.present?
      #     posts = posts.where(user_id: author_id)
      #   end
      #   if title.present?
      #     posts = posts.where("title ILIKE ?", "%#{title}%")
      #   end

      #   if body.present?
      #     posts = posts.where("body ILIKE ?", "%#{body}%")
      #   end
      #   posts
      # end

      def resolve(**args)
        local        = ::PostsQuery.new(params: args, skip: args[:skip]).run.to_a
        external     = fetch_external_posts
        local_titles = local.map { |p| p.title.to_s.downcase }.to_set
        unique_external = external.reject { |p| local_titles.include?(p.title.to_s.downcase) }


        local + unique_external
      end

      private
      def fetch_external_posts
        ::PostFaradayServices.new.fetch_all.map do |data|
          post            = ::Post.new(title: data["title"], body: data["body"], status: :draft)
          post.id         = data["id"].to_i
          post.created_at = 1.year.from_now
          post.updated_at = post.created_at
          post
        end
      rescue ::Faraday::Error => e
        Rails.logger.warn("[PostsResolver] API down: #{e.message}")
        []
      end
    end
  end
end
