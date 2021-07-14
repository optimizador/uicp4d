# config.ru
require './basic'
require 'rack/protection'
use Rack::Protection, permitted_origins: ["http://localhost:3000"]
run Sinatra::Application
