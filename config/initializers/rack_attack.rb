module Rack
  class Attack
    GRAPHQL_ENDPOINT = "/graphql".freeze
    LOGIN_ENDPOINT = "users/sign_in".freeze
    LOGIN_IP_lIMIT = Rails.env.test? ? 100 : 5
    GRAPHQL_IP_LIMIT = Rails.env.test? ? 100 : 5
    throttle("login/ip", limit: LOGIN_IP_lIMIT, period: 1.minutes) do |req| # throttle rack attack method to take arguement
      if req.path == LOGIN_ENDPOINT && req.post?
        req.ip
      end
    end

    throttle("graphql/ip", limit: GRAPHQL_IP_LIMIT, period: 1.minutes) do |req|
      if req.path == GRAPHQL_ENDPOINT && req.post?
        req.ip
      end
    end

    blocklist("block_suspicious-agent") do |req|
      suspicious_agents = [
      /sqlmap/i,   # SQL injection tool
      /nmap/i,     # network scanner
      /nikto/i,    # web vulnerability scanner
      /masscan/i,  # port scanner
      /zap/i       # OWASP attack proxy
      ]
      user_agent = req.get_header("HTTP_USER_AGENT").to_s
      suspicious_agents.any? { |pattern| user_agent.match?(pattern) }
    end
  end
end
