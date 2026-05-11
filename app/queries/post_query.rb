class PostQuery < BaseQuery
  attr_accessor :title, :body, :status, :author_id
  def initialize(params: {}, skip: 0)
    super
    @staus = params[:status]
    @title = params[:title]
    @author_id = params[:author_id]
    @body = params[:body]
  end

  private
end
