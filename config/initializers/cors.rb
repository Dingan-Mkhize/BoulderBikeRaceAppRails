# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://project7-bike-race-site-production.up.railway.app'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
  end
end