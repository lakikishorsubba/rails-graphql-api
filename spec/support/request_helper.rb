module RequestHelper
  def graphql_request(query, variables: {}, user: nil)
    headers = { "Content-Type" => "application/json" }
    if user
      token = generate_token(user)
      headers["Authorization"] = "Bearer #{token}" # [] is a method called in the variable header, and Authorization is a key and bearer__ is a value
    end
    post "/graphql",
      params: { query: query, variables: variables }.to_json,
      headers: headers # string key value pair
  end

  def graphql_response
    JSON.parse(response.body)
  end
  def graphql_data
    graphql_response["data"]
  end

  def graphql_errors
    graphql_response["errors"]
  end
end
