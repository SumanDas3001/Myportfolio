OmniAuth.config.silence_get_warning = true
# OmniAuth.config.allowed_request_methods = [:post, :get]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch("TWITTER_CONSUMER_KEY"), ENV.fetch("TWITTER_CONSUMER_SECRET")
end