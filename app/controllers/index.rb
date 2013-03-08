get '/' do
  erb :index
end

post '/login' do
  @player = Player.find_by_email(params[:email])
  if @player && @player.authenticate(params[:password])
    session[:player_id] = @player.id
    redirect "/arena"
  else
    @errors = "yo we got problems"
    erb :index
  end
end

post '/signup' do
  @player = Player.new(params)
  if @player.save
    session[:player_id] = @player.id
    redirect '/arena'
  else
    erb :index
  end
end


get '/logout' do 
  session.clear
  redirect '/'
end


get '/game/:game_id' do
  @game = Game.find(params[:game_id]) 
  erb :game
end

post '/game/:game_id/join' do 
  @game = Game.find(params[:game_id])
  @game.players << Player.find(session[:player_id])
  redirect "/game/#{@game.id}"
end

get '/arena' do 
  @games = Game.all
  erb :arena
end

post '/game/new' do
  game = Game.new(params)
  if game.save
    game.generate_spaces
    redirect "/game/#{game.id}"
  else
    erb :arena
  end
end

post '/game/:game_id/update' do 
  space_location = params[:space]
  game = Game.find(params[:game_id])
  status = Player.find(session[:player_id]).id
  #update the correct space
  space = game.spaces.find_by_space_location(space_location)
  space.update_attribute(:status, status)
  "true"
end

post '/game/:game_id/status' do
  content_type :json
  game = Game.find(params[:game_id])
  latest_turn = game.spaces.order("created_at DESC").last
  current_user = Player.find(session[:player_id])
  if current_user == latest_turn.player
    {:status => "No go"}.to_json
  else
    {:status => "wahoo"}.to_json
  end
end







