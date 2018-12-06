Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, '2156967390989376', 'a659445402b546c627c504186daa138a',
           client_options: {
             site: 'https://graph.facebook.com/v3.0',
             authorize_url: 'https://www.facebook.com/v3.0/dialog/oauth',
             display: 'popup'
           },
           origin_param: false
end
