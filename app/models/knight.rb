class Knight < Piece
  def valid_move?(x, y)
    move_range = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    available_moves = []

    move_range.each do |dx, dy|
      available_moves << [(x_position + dx), (y_position + dy)]
    end
    available_moves.include?([x,y])
  end
  
end
