helpers do 

  
  
  def current_player
    @current_player = Player.find(session[:player_id])
  end
end 
