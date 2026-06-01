SecureHeaders::Configuration.default do |config|
  # disallow iframe
  config.x_frame_options = "SAMEORIGIN" # setter method

  # disallow browser to guess the content type
  config.x_content_type_options = ("nosniff") # setter method
end
