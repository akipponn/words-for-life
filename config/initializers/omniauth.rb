Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, TW_CONSUMER_KEY, TW_CONSUMER_SECRET
  provider :facebook, FB_CONSUMER_KEY, FB_CONSUMER_SECRET, {:scope => 'email, publish_stream'}
end