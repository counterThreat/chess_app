function setBoard(){
  var url = window.location.href;

// refreshes the board
  $.get(url + "/pieces").success(function(data){
  for(var x = 0; x < 8; x++) {
    for (var y = 0; y < 8; y++) {
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
  var square = $(this);
  var piece = $(element);

  var piece_id = piece.attr('data-id');
  var destination_x = square.attr('data-x');
  var destination_y = square.attr('data-y');

  var url = window.location.href + '/pieces/' + piece_id;
  $.ajax({
    type: 'POST',
    url: url,
    data: { _method: 'PATCH', x_position: destination_x, y_position: destination_y },
    success: function(msg){
      console.log('success!');
      setBoard();
    }
  });
}

function dragDropPiece(){
  $('.piece').draggable({ snap: ".square"});
  $('.square').droppable({
    onDrop: handleDrag
  });
}

$( document ).ready(function(){
  setBoard();
});
