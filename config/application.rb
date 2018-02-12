require_relative 'environment'
Dir[File.join(__dir__, 'initializers/*.rb')].each { |f| require f }
require_relative 'middleware'

require_relative '../app/api'

Application = Rack::Builder.new do
  use Rack::CommonLogger, Log.error_stream
  if ENV['RACK_ENV'] == 'development'
    use Rack::ShowExceptions
  else
    use Middleware::RescueExceptions
  end
  use Middleware::LogExceptions
  use Rack::Reloader

  map '/' do
    status_server = lambda do |_env|
      [200,
       { 'Content-Type' => 'application/json' },
       ['Server is working'.to_json]]
    end
    run status_server
  end

  map '/api' do
    run API.app
  end
end.to_app
