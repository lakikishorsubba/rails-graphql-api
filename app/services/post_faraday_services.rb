class PostFaradayServices # class responsible for api request.
  # constant variable: base url
  BASE_URL = "https://jsonplaceholder.typicode.com"

  # constructor that creates reusable HTTP connection.
  def initialiaze
    # instance variable to build farady request.
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.headers["content-type"] =  "application/json"
      faraday.headers["Accept"] = "application/json"
      faraday.request  :retry, max: 3
      faraday.adapter  Faraday.default_adapter
    end
  end
end
