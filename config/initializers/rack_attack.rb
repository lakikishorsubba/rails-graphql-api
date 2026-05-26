module Rack
  class Attack
    throttle("login/ip", limit: 5, period: 1.minutes) do |req| # throttle rack attack method to take arguement
      if req.path == "/users/sign_in" && req.post?
        req.ip
      end
    end

    throttle("graphql/ip", limit: 5, period: 1.minutes) do |req|
      if req.path == "/graphql" && req.post?
        req.ip
      end
    end
  end
end
