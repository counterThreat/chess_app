# class Rook < Piece
#   def valid_move?(x_new, y_new)
#     if exposes_king_to_attack?(x, y)
#       false
#     elsif obstructed?(x_new, y_new)
#       false
#     elsif x_position == x_new || y_position == y_new
#       true
#     else
#       super
#     end
#   end
# end

class Rook < Piece
  def valid_move?(x_new, y_new)
    super && !obstructed?(x_new, y_new) && (x_position == x_new || y_position == y_new)
  end
end
