get '/' do
  if session[:user] != nil
    redirect "/index"
  else
    redirect "/login"
  end
end

get '/index' do
  @user = User.find_by(id: session[:user])
  @user_stacks = @user.stacks
  erb :index
end


get '/login' do
  @errors = session[:errors]
  session[:errors] = nil
  erb :login
end

post '/login' do
  if User.find_by(email: params[:email])
    user = User.find_by(email: params[:email])
  else
    session[:error] = "Incorrect Credentials"
    redirect '/login'
  end

  if user.authenticate(params[:password])
    session[:user] = user.id
    session.delete(:error )
  else
    session[:error] = "Incorrect Credentials"
    redirect '/login'
  end
  redirect '/'
end


get '/logout' do
  erb :index
end

post '/logout' do
  session.delete(:user)
  redirect '/'
end




get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  user = User.create(email:params[:email], password:params[:password])
  session[:user] = user.id
  redirect "/"
end

get '/show/:id' do
  @stack = Stack.find(params[:id])
  @photo = Facecard.all.sample.face_url
  erb :show
end









