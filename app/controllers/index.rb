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
  status = Player.find(session[:player_id]).id #missing the X & O logic
  #update the correct space
  space = game.spaces.find_by_space_location(space_location)
  space.update_attributes(:status => status, :player_id => current_player.id)
  {mark: current_player.id}.to_json
end

post '/game/:game_id/status' do
  content_type :json
  game = Game.find(params[:game_id])
  if current_player == game.latest_player #method to check for turn. 
    {:status => "No go"}.to_json
  else
    # board_as_string = erb :_board, :layout => false, :locals => {:game => game}
    {:status => "wahoo", :space => game.latest_space, :mark => game.latest_player.id}.to_json
  end
end







