
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

function allowDrop(event){
  event.preventDefault();
}

function handleDrag(element){
  // element that's being dropped
  var chess_piece = $(element);
  var square = $(this);

  var chess_piece_id = chess_piece.attr('data-id');
  var dx = square.attr('data-x');
  var dy = square.attr('data-y');

  var url = window.location.href + '/pieces/' + chess_piece_id;

  $.ajax({
    type: "PATCH",
    url: ui.draggable.data('url'),
    //_method: 'PATCH',
    dataType: 'script',
    data: {
      piece: {
        x_position: dx,
        y_position: dy
      }
    },
    success: function(data){
      setBoard();
    }
  });
}

function dragDropPiece(){
  $('.piece').draggable({ containment: ".chessboard", snap: ".square", snapMode: 'inner', revert: true });
  $('.square').droppable({
    drop: handleDrag
  });
}

$( document ).ready(function(){
  setBoard();
});

///
///
///

/*
function dragDrop(){
  $(".piece").draggable({
    containment: '.chessboard',
    snap: '.square',
    snapMode: 'inner',
    revert: true,
  });

  $('.square').droppable({
    drop: handleDrag,
    hoverClass: 'hoveredSquare'
  });
}

function handleDrag(event, ui){
  ui.draggable.draggable('option', 'revert', false);
  ui.draggable.position({
    of: $(this)
    my: 'left top',
    at: 'left top'
  });
  var dx = $(this).data("x");
  var dy = $(this).data("y");

  $.ajax({
    type: 'PATCH',
    url: ui.draggable.data('url'),
    dataType: 'script',
    data: { piece: { x_position: dx, y_position: dy ) }
  });
}
*/
