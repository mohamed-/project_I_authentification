# fichier principal de l'application Sinatra
require 'sinatra'

class User
end

get '/users/new' do 
  erb :registration
end

post '/users' do 
  u = User.create(params['user'])  
  if u
    redirect "/users/#{params['user']['login']}"
  else
    erb :registration
  end
end

get "/users/:login" do 
  "bonjoun #{login}"
end
