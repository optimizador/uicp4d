require 'sinatra'
set(:cookie_options) do
  { :expires => Time.now + 30*60 }
end
get '/' do
  logger = Logger.new(STDOUT)
  logger.info(request)
  #@name = "Pedro"
  response.set_cookie("llave", value: "valor")
  erb :index

end

get '/nombre' do
  logger = Logger.new(STDOUT)
  logger.info("Recibi lo siguiente #{params[:name]}")
  @name = "#{params[:name]}"
  response.set_cookie("llave2", value: "valor2")
  erb :index
end
