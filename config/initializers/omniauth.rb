Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['facebook_app_id'], ENV['facebook_app_secret'],
           client_options: {
             site: ENV['facebook_graph_api'],
             authorize_url: 'https://www.facebook.com/v3.2/dialog/oauth'
           },
           scope: 'manage_pages,pages_show_list,public_profile,pages_messaging',
           display: 'touch'
end
