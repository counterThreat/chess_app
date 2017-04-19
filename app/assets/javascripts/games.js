$( document ).ready(function(){

  $.get("/pieces").success(function(data){
    $.each(data, function(index, piece){
      $("#" + piece.x_position + piece.y_position).html(piece.unicode);
      $("#" + piece.x_position + piece.y_position).attr('data-id', piece.id);
    });
  });





});
