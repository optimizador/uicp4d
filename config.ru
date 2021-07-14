# config.ru
require './basic'
require 'rack/protection'
use Rack::Protection, permitted_origins: ["https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"], :session => false
run Sinatra::Application
