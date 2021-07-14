# config.ru
require './basic'
require 'rack/protection'
disable :protection
run Sinatra::Application
