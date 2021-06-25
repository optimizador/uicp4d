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

get '/loganalysis' do
  redirect "https://ui-monitoring.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/VATLA?"
  #redirect "http://localhost:8090"
end

get '/monitoring' do
  redirect "https://ui-monitoring.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/VLG?"
  #redirect "http://localhost:8090"
end

get '/pxbackup' do
  redirect "https://pxbackup.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
  #redirect "http://localhost:8090"
end
get '/iks' do
  redirect "https://iks-ocp.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/iks"
end
get '/ocp' do
  redirect "https://iks-ocp.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/ocp"
end
get '/cr' do
  redirect "https://ui-cr.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
end

get '/cp4d' do
  logger = Logger.new(STDOUT)
  logger.info("Selecciono dimensionamiento para CP4D")
  @name = "CP4D"
  respuestasizing=[]
  respuestasizingalt=[]
  respuestastorage=[]
  response.set_cookie("llave2", value: "valor2")
    erb :cp4d , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestastorage => respuestastorage}
end

get '/cp4drespuesta' do

  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de CP4D: CPU: #{params[:cpu]} RAM: #{params[:ram]} Storage: #{params[:storage]} IOPS #{params[:iops]}")
  @name = "CP4D-Dimensionamiento"
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  #urlapi="http://localhost:8080"
  cpu="#{params['cpu']}"
  ram="#{params['ram']}"
  storage="#{params['storage']}"
  iops="#{params['iops']}"

  #parametros recibidos
  respuestasizing = RestClient.get "#{urlapi}/api/v1/sizingclusteroptimo?cpu='#{cpu}'&ram='#{ram}'&region=mexico", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  respuestasizingalt = RestClient.get "#{urlapi}/api/v1/sizingcluster?cpu='#{cpu}'&ram='#{ram}'&region=mexico", {:params => {}}
  respuestasizingalt=JSON.parse(respuestasizingalt.to_s)
  logger.info(respuestasizingalt)

  respuestastorage = RestClient.get "#{urlapi}/api/v1/sizingblockstorage?iops=#{iops}&storage=#{storage}&region=mexico", {:params => {}}
  respuestastorage=JSON.parse(respuestastorage.to_s)
  logger.info(respuestastorage)

  #erb :cp4d , :locals => {:respuestasizing => params[:respuestasizing]}
  erb :cp4d , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestastorage => respuestastorage}
end
