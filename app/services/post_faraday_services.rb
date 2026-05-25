class PostFaradayServices # class responsible for api request.
  # constant variable: base url
  BASE_URL = "https://jsonplaceholder.typicode.com"

  # constructor that creates reusable HTTP connection.
  def initialize
    # instance variable to build farady request.
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.headers["content-type"] =  "application/json"
      faraday.headers["Accept"] = "application/json"
      faraday.request  :retry, max: 3
      faraday.adapter  Faraday.default_adapter
    end
  end

  def fetch_all
    response = @connection.get("/posts") # apped to base url
    JSON.parse(response.body)
  end

  def fetch_one(id)
    response = @connection.get("/posts/#{id}")
    JSON.parse(response.body)
  end
end
