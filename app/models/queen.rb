# class Queen < Piece
#   def valid_move?(x, y)
#     return false unless super(x, y)
#     return false if is_obstructed?(x, y)
#     return false if exposes_king_to_attack?(x, y)
#     diagonal_move?(x, y) || horizontal_move?(x, y) || vertical_move?(x, y)
#   end
# end

class Queen < Piece
  def valid_move?(x, y)
    return false unless super(x, y)
    return false if is_obstructed?(x, y)
    diagonal_move?(x, y) || horizontal_move?(x, y) || vertical_move?(x, y)
  end
end
