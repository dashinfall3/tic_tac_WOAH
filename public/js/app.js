$(document).ready(function(){

  game = {
    id: $('.board').attr('id'),
  }

  // when player clicks on space:
  // - ajax post to update the game
  $('.space').on("click", function(){
    var space = $(this).attr('id'); 
    $.ajax({
      url: '/game/' +game['id']+ '/update',
      type: 'post',
      data: {game_id: game['id'], space: space},
      dataType: 'json'
    }).done(function(serverResponse) {
      $('body').append('<h3> Nice move!!!! </h3>');
      // disable board
    })
  });



  // check every second if it's my turn
  //   $.ajax({
  //     url: '/game/' +game[id]+ '/check_status',
  //     type: 'get'
  //     dataType: 'json'
  //   }).done(function(serverResponse) {
  //     if true, re-enable board
  //   })
  // });



});

