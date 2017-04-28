
function pieceClass(data){
  var url = window.location.href;

  data.forEach(function(piece){
    var cssSelector = "#" + piece.x_position + piece.y_position;
    var square = $(cssSelector);
    var chess_piece = $("<div></div>");
    chess_piece.html(piece.unicode);
    chess_piece.addClass('piece');
    chess_piece.attr('data-id', piece.id);
    square.html('');
    square.html(chess_piece);
  });

  dragDropPiece();
};

function dragDropPiece(){
  $('.piece a').draggable({
    containment: ".chessboard",
    snap: ".square",
    snapMode: 'inner',
    revert: 'invalid'
    start: function(event, ui){
      url = ui.helper.attr('href' + '/valid_moves' ),
      $.get(url).success(function(response){
        response.forEach(position){
          $("[data-x={position.x}][data-y=#{position.y}]").addClass('valid-move');
        };
      });
    },
    stop: $('.valid-move').removeClass('valid-move')
  });
  $('.square').droppable({
    //drop: handleDrag
    drop: function(event,ui){
      var $target = $(event.target);
      var piece = ui.draggable.attr('data-id') ;
      var piece_url = piece.attr('href');

      $.ajax({
        url: piece_url,
        method: 'PUT',
        data: {
          piece: {
            x_position: $target.data('x'),
            y_position: $target.data('y')
          }
        },
        error: function(response){
          ui.draggable.animate[(
            top: 0;
            left: 0;
          )],
        },
      });
    }
  });
};

/*


function handleDrag(element){
  var chess_piece = $(element);
  var square = $(this);
  var piece_id = chess_piece.attr('data-id');
  var dx = square.attr('data-x');
  var dy = square.attr('data-y');

  var url = window.location.href + '/pieces/' + piece_id;

  $.ajax({
    type: "PATCH",
    url: url,
    //_method: 'PATCH',
    dataType: 'script',
    data: {
      piece: {
        x_position: dx,
        y_position: dy
      }
    };
  });
}

$( document ).ready(function(){
  pieceClass();
});



/*
function setBoard(){
  var url = window.location.href;

// refreshes the board
  $.get(url + "/pieces").success(function(data){
  for(var x = 0; x <= 7; x++) {
    for (var y = 0; y <= 7; y++) {
      var square = $('#' + x + y);
      //square.html('');
    }
  }

    // data creates an array of pieces
    data.forEach(function(piece){
      var cssSelector = "#" + piece.x_position + piece.y_position;
      var square = $(cssSelector);
      console.log(square);

      var chess_piece = $('<div></div>');
      chess_piece.html(piece.unicode);
      chess_piece.addClass('piece');
      chess_piece.attr('data-id', piece.id);
      chess_piece.attr('data-x-position', piece.x_position);
      chess_piece.attr('data-y-position', piece.y_position);
      chess_piece.attr('piece-type', piece.type);
      chess_piece.attr('piece-uniocde', piece.unicode);
      chess_piece.attr('piece-user-id', piece.user_id);

      square.html('');
      square.html(chess_piece);
    });

    dragDropPiece();
  });
}

*/
