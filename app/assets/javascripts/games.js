
function setBoard(){
  var url = window.location.href;

// refreshes the board
  $.get(url + "/pieces").success(function(data){
  for(var x = 0; x <= 7; x++) {
    for (var y = 0; y <= 87; y++) {
      var square = $('#' + x + y);
      square.html('');
      console.log('refreshes board');
    }
  }

    // data creates an array of pieces
    console.log("puts pieces on the board");
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

function allowDrop(event){
  event.preventDefault();
}

function handleDrag(element){
  // element that's being dropped
  var piece = $(element);
  var square = $(this);

  var piece_id = piece.attr('data-id');
  var dx = square.attr('data-x');
  var dy = square.attr('data-y');
  var user = piece.attr('piece-user-id');
  var type = piece.attr('piece-type');

  var url = window.location.href + '/pieces/' + piece_id;

  $.ajax(url, {
    type: 'POST',
    data: { _method: 'PATCH', x_position: dx, y_position: dy },
    //x_position: destination_x,
    //y_position: destination_y,
    success: function(data){
      setBoard();
    }
  });
}

function dragDropPiece(){
  $('.piece').draggable({ containment: ".chessboard", snap: ".square"});
  $('.square').droppable({
    drop: handleDrag
  });
}

$( document ).ready(function(){
  setBoard();
});
