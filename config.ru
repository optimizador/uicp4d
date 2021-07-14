# config.ru
require './basic'
require 'rack/protection'
run Sinatra::Application
