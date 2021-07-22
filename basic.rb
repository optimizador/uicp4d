require 'sinatra'
require 'rest-client'

set(:cookie_options) do
  { :expires => Time.now + 30*60 }
end

#************
#Copiar y actualizar en cada módulo
# ***Adaptar para que no se reescriban las rutas del módulo en particular donde se despliegue
#************
get '/' do
  logger = Logger.new(STDOUT)
  logger.info(request)
  #response['Access-Control-Allow-Origin'] = 'https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/'
  erb :index

end
get '/uidl' do
  redirect "https://ui-ga.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/uidl"
end
get '/uiga' do
  redirect "https://ui-ga.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/uiga"
  #redirect "http://localhost:8090"
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
#************
#Fin Copiar y actualizar en cada módulo
#************


get '/cp4d' do
  logger = Logger.new(STDOUT)
  logger.info("Selecciono dimensionamiento para CP4D")
  @name = "CP4D"
  respuestasizing=[]
  respuestasizingalt=[]
  respuestastorage=[]
  #response['Access-Control-Allow-Origin'] = 'https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/'
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
  infra_type="#{params['infra_type']}"
  region="#{params['region']}"
  storage="#{params['storage']}"
  iops="#{params['iops']}"

  #parametros recibidos
  logger.info("PRIMER LLAMADO DE API #{urlapi}/api/v2/sizingclusteroptimo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}")
  respuestasizing = RestClient.get "#{urlapi}/api/v2/sizingclusteroptimo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  logger.info("SEGUNDO LLAMADO DE API #{urlapi}/api/v2/sizingcluster?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}")
  respuestasizingalt = RestClient.get "#{urlapi}/api/v2/sizingcluster?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizingalt=JSON.parse(respuestasizingalt.to_s)
  logger.info(respuestasizingalt)
  logger.info("TERCER LLAMADO DE API #{urlapi}/api/v1/sizingblockstorage?iops=#{iops}&storage=#{storage}&region=#{region}")
  respuestastorage = RestClient.get "#{urlapi}/api/v1/sizingblockstorage?iops=#{iops}&storage=#{storage}&region=#{region}", {:params => {}}
  respuestastorage=JSON.parse(respuestastorage.to_s)
  logger.info(respuestastorage)
  logger.info("TERMINO DE LLAMAR LOS APIS")
  #erb :cp4d , :locals => {:respuestasizing => params[:respuestasizing]}
  #response['Access-Control-Allow-Origin'] = 'https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/'
  erb :cp4d , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestastorage => respuestastorage}
end

  get '/cp4dtemplate' do
    logger = Logger.new(STDOUT)
    logger.info("Selecciono dimensionamiento para template de CP4D")
    @name = "CP4D"
    respuestasizing=[]
    respuestasizingalt=[]
    respuestastorage=[]
    #response['Access-Control-Allow-Origin'] = 'https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/'
    erb :cp4dtemplate , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestastorage => respuestastorage}
  end
  get '/cp4dtemplaterespuesta' do
    logger = Logger.new(STDOUT)
    logger.info("Selecciono dimensionamiento para template de CP4D")
    @name = "CP4D"
    respuestasizing=[]
    respuestasizingalt=[]
    respuestastorage=[]
    #response['Access-Control-Allow-Origin'] = 'https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/'
    erb :cp4dtemplate , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestastorage => respuestastorage}
  end
