class Knight < Piece
  def valid_move?(x_new, y_new)
    if (x_new - x_position).abs == 2 && (y_new - y_position).abs == 1 ||
       (x_new - x_position).abs == 1 && (y_new - y_position).abs == 2
       true
     else 
      super
    end
  end
end
