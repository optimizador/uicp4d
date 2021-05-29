require 'sinatra'
require 'rest-client'

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
  respuestasizing=[]
  respuestastorage=[]
  response.set_cookie("llave2", value: "valor2")
    erb :cp4d , :locals => {:respuestasizing => respuestasizing, :respuestastorage => respuestastorage}
end

get '/cp4drespuesta' do
  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de CP4D: CPU: #{params[:cpu]} RAM: #{params[:ram]} Storage: #{params[:storage]} IOPS #{params[:iops]}")
  @name = "CP4D-Dimensionamiento"
  cpu="#{params['cpu']}"
  ram="#{params['ram']}"
  storage="#{params['storage']}"
  iops="#{params['iops']}"

  #parametros recibidos
  respuestasizing = RestClient.get "http://localhost:8080/api/v1/sizingcluster?cpu='#{cpu}'&ram='#{ram}'", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  respuestastorage = RestClient.get "http://localhost:8080/api/v1/sizingblockstorage?iops=#{iops}&storage=#{storage}&region=mexico", {:params => {}}
  respuestastorage=JSON.parse(respuestastorage.to_s)
  logger.info(respuestastorage)

  #erb :cp4d , :locals => {:respuestasizing => params[:respuestasizing]}
  erb :cp4d , :locals => {:respuestasizing => respuestasizing, :respuestastorage => respuestastorage}
end
