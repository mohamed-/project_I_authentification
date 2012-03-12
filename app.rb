# fichier principal de l'application Sinatra
$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'sinatra'
require 'user'

get '/users/new' do 
  erb :registration
end

post '/users' do 
  u = User.new(params['user'])  
  if u.save
    redirect "/users/#{params['user']['login']}"
  else
    erb :registration
  end
end

get "/users/:login" do 
  "bonjoun #{login}"
end
