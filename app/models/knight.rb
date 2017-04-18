class Knight < Piece
  # def valid_move?(x_position, y_position)
  #   return false unless super(x, y)
  #   return false if exposes_king_to_attack?(x, y)
  #   move_range = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
  #   available_moves = []
  #   move_range.each do |dx, dy|
  #     available_moves << [(x_position + dx), (y_position + dy)]
  #   end
  #   available_moves.include?([x_position, y_position])
  # end
end
