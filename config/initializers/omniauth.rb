Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['facebook_app_id'], ENV['facebook_app_secret'],
           client_options: {
             site: 'https://graph.facebook.com/v3.0',
             authorize_url: 'https://www.facebook.com/v3.0/dialog/oauth',
             display: 'popup'
           },
           origin_param: false
end
