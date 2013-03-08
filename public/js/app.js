$(document).ready(function(){

  $('.space').on("click", function(){
    var id = $(this).attr('id'); 
    $.post('/game/update', {player, id}).done(function(server_response){
 });
});
