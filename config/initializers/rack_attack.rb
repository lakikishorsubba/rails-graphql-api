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
