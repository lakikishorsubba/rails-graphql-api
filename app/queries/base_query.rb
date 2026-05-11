class BaseQuery # to hold filtering logic
  attr_reader :query, :skip

  def initilaize(params: {}, skip: 0)
    @params = params
    @skip = skip.to_i
    @query = params[:query]
  end
end
