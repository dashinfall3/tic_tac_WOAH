get '/' do
  erb :index
end

post 'login' do
  session[:user_id] == User.authenticate(params[:email], params[:password])
  if session[:user_id]
    redirect "/games/#{session[:user_id]}"
  else
    erb :index
  end
end

post '/signup' do
  player = Player.new(params)
  session[:user_id] = player.authenticate(params[:email], params[:password])

  if player.save
    redirect '/arena'
  else
    erb :signup
  end
end

get '/game/:game_id' do
  @game = Game.find(params[:game_id]) 
  erb :game
end

get '/arena' do 
  @games = Game.all
  erb :arena
end

post '/game/new' do
  game = Game.new(params)
  # in before create create all the spaces for this game
  if game.save
    game.generate_spaces
    redirect "/game/#{game.id}"
  else
    erb :arena
  end
end
