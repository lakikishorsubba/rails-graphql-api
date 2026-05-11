class BaseQuery # to hold filtering logic
  attr_reader :query, :skip

  def initilaizer(params: {}, skip: 0)
    @params = params
    @skip = skip.to_id
    @query = params[:query]
  end
end
