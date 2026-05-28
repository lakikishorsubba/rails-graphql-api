SecureHeaders::Configuration.default do |config|
  config.x_frame_options = "SAMEORIGIN" # setter method
end
