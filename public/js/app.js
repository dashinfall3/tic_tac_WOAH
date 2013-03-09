$(document).ready(function(){

game = {

  id: $('.board').attr('id'),
  board: $('.board'),

  updateSpace: function() {
    $('.space').on("click", function(){
      var space_id = $(this).attr('id');
      if (!game.board.hasClass('disabled')) {
        $.ajax({
          url: '/game/' +game['id']+ '/update',
          type: 'post',
          data: {game_id: game['id'], space: space_id},
          dataType: 'json'
        }).done(function(data) {
          game.board.addClass('disabled');
          $('body').append('<h3> Nice move!!!! </h3>');
          $('#'+space_id).html(data.mark);
          //window.setInterval(game.checkStatus, 2000);
          $
        })
      }
      
    });
  },

  checkStatus: function(){
    $.ajax({
      url: '/game/' +game['id']+ '/status',
      type: 'post',
      dataType: 'json'
    }).done(function(data) {
      if (data['status'] === 'wahoo') {
          game.board.removeClass('disabled');
          $('#'+data.space).html(data.mark);
      }

    });
  },

}


window.setInterval(game.checkStatus, 2000);
game.updateSpace();

});

// TODO: add class marked to spaces 

  
