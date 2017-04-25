$( document ).ready(function(){
var url = $(location).attr('href');
  $.get(url+"/pieces").success(function(data){
    $.each(data, function(index, piece){
      $("#" + piece.x_position + piece.y_position).html(piece.unicode);
      $("#" + piece.x_position + piece.y_position).attr('data-id', piece.id);
    });
  });





});
$(function() {
  var classHighlight = 'highlight';
  var pieces = $('.square');
  $('.square').click(function(item) {
    $('.square').removeClass(classHighlight);
    $( this ).addClass(classHighlight);
  });
});
