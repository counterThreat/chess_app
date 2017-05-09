

function setBoard(){
  var url = window.location.href;

// refreshes the board
  $.get(url + "/pieces").success(function(data){
    for(var x = 1; x <= 8; x++) {
      for (var y = 1; y <= 8; y++) {
        var square = $('#' + x + y);
        square.html('');
      }
    }

    // puts pieces on the board
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

function handleDrag(event, ui){
  var chess_piece = $(ui.draggable);
  var square = $(this);

  var piece_id = chess_piece.attr('data-id');
  var dx = square.attr('data-x');
  var dy = square.attr('data-y');

  var url = window.location.href + '/pieces/' + piece_id;

  $.ajax({
    url: url,
    type: 'PUT',
    data: { piece: { x_position: dx, y_position: dy, id: piece_id }, _method: 'patch' },
    success: function(data){
      //setBoard(); // could be causing lag in piece move
    }
  });
}

function dragDropPiece(){
  $('.piece').draggable({
    containment: ".chessboard",
    snap: ".square",
    snapMode: 'inner',
    snapTolerance: 40
    //revert: true
  });
  $('.square').droppable({
    drop: handleDrag
    // add revert false for when the drop is valid
  });
}

function showMove() {
  // Enable pusher logging - don't include this in production
  Pusher.logToConsole = true;

  var pusher = new Pusher('85619837e880f6d5568c', {
    encrypted: true
  });

  var channel = pusher.subscribe('my-channel');
  channel.bind('piece-moved', function(data) {
    console.log(data.message);
  });
}

$( document ).ready(function(){
  setBoard();
});
