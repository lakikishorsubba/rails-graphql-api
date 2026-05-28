module Rack
  class Attack
    GRAPHQL_ENDPOINT = "/graphql".freeze
    LOGIN_ENDPOINT = "/users/sign_in".freeze
    LOGIN_IP_LIMIT = Rails.env.test? ? 5 : 5
    GRAPHQL_IP_LIMIT = Rails.env.test? ? 5 : 5

    # subscribe the rack.attack
    ActiveSupport::Notifications.subscribe("rack.attack") do |_name, _start, _finish, _request_id, payload|
      req = payload[:request] # needed for now
      Rails.logger.warn(
        "[Rack::Attack] " \
        "matched=#{req.env['rack.attack.matched']} " \
        "ip=#{req.ip} " \
        "method=#{req.request_method} " \
        "path=#{req.fullpath}"
      )
    end
    throttle("login/ip", limit: LOGIN_IP_LIMIT, period: 1.minutes) do |req| # throttle rack attack method to take arguement
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

    # respond for rate limit
    self.throttled_responder = lambda do |env|
      rack_env   = env.respond_to?(:[]) ? env : env.env
      match_data = rack_env["rack.attack.match_data"]

      if match_data
        now     = match_data[:epoch_time]
        headers = {
          "Content-Type"          => "application/json",
          "Retry-After"           => match_data[:period].to_s,
          "X-RateLimit-Limit"     => match_data[:limit].to_s,
          "X-RateLimit-Remaining" => "0",
          "X-RateLimit-Reset"     => (now + match_data[:period]).to_s
        }
      else
        headers = { "Content-Type" => "application/json" }
      end

      body = {
        errors: [ {
          message: "Rate limit exceeded. Please try again later.",
          extensions: {
            code: "RATE_LIMITED",
            retryAfter: match_data&.dig(:period) || 60
          }
        } ]
      }.to_json

      [ 429, headers, [ body ] ]
    end

    # blocklist response
    self.blocklisted_responder = lambda do |_env|
  body = {
    errors: [ {
      message: "Forbidden",
      extensions: { code: "FORBIDDEN" }
    } ]
  }.to_json

    [ 403, { "Content-Type" => "application/json" }, [ body ] ]
  end
  end
end
