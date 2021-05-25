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

get '/cp4d' do
  logger = Logger.new(STDOUT)
  logger.info("Selecciono dimensionamiento para CP4D")
  @name = "CP4D"
  response.set_cookie("llave2", value: "valor2")
  erb :cp4d
end

get '/cp4drespuesta' do
  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de CP4D: CPU: #{params[:cpu]} RAM: #{params[:ram]} Storage: #{params[:storage]} IOPS #{params[:iops]}")
  @name = "CP4D"
  response.set_cookie("llave2", value: "valor2")
  erb :cp4d
end
