# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001' # Update with the actual URL of your React app
    resource '*', headers: :any, methods: [:get, :post, :options]
  end
end