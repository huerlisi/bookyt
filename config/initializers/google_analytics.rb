# Google analytics middleware.
begin
  if Object.const_defined?(:Rack) and Rack.const_defined?(:GoogleAnalytics) and Settings['google_analytics']
    Rails.application.config.middleware.use("Rack::GoogleAnalytics", :web_property_id => Settings.google_analytics.api_key)
  end
rescue
end
