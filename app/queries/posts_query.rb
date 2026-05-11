class PostsQuery < BaseQuery
  attr_accessor :title, :body, :status, :author_id
  def initialize(params: {}, skip: 0)
    super # inherit variable from super class
    @status = params[:status] # instance variable
    @title = params[:title]
    @author_id = params[:author_id]
    @body = params[:body]
  end

  def run
  ::Post.all # just a query builder
    # can use {}, but used do end just to make more redable
    .then do |posts| # iterate over each post and .then will move to another blocks
      by_status(posts) # pass posts to method by_status
    end
    .then do |posts|
      by_author(posts)
    end
    .then do |posts|
      by_title(posts)
    end
    .then do |posts|
      by_body(posts)
    end
    .order(created_at: :asc)
    .offset(skip)
  end

  private
  def by_status(posts)
    return posts if status.blank?
    posts.where(status: status)
  end

  def by_author(posts)
    return posts if author_id.blank?
    posts.where(user_id: author_id)
  end

  def by_title(posts)
    return posts if title.blank?
    posts.where("title ILIKE ?", "%#{title}%")
  end

  def by_body(posts)
    return posts if body.blank?
    posts.where("body ILIKE ?", "%#{body}%")
  end
end
