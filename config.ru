# config.ru
require './basic'
require 'rack/protection'
set :protection, :except => :frame_options
run Sinatra::Application
