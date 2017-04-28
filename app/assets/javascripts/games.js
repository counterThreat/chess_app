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

      square.html('');
      square.html(chess_piece);
    });

    dragDropPiece();
  });
}

function handleDrag(element){
  // element that's being dropped
  var chess_piece = $(element);
  var square = $(this);

  var piece_id = chess_piece.attr('data-id');
  console.log(piece_id);
  var dx = square.attr('data-x');
  var dy = square.attr('data-y');
  var user = chess_piece.attr('piece-user-id');
  var type = chess_piece.attr('piece-type');

  var url = window.location.href + '/pieces/' + piece_id;

  $.ajax({
    url: url,
    type: 'PUT',
    data: { piece: { x_position: dx, y_position: dy, id: piece_id }, _method: 'patch' },
    //x_position: destination_x,
    //y_position: destination_y,
    success: function(data){
      setBoard();
    }
  });
}

function dragDropPiece(){
  $('.piece').draggable({ containment: ".chessboard", 
                          snap: ".square",
                          snapMode: 'inner',
                          revert: true });
  $('.square').droppable({
    drop: handleDrag
    // add revert false for when the drop is valid
  });
}

$( document ).ready(function(){
  setBoard();
});
