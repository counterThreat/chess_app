# class Bishop < Piece
#   def valid_move?(x_new, y_new)
#     if obstructed?(x_new, y_new)
#       false
#     elsif exposes_king_to_attack?(x, y)
#       false
#     elsif (x_position - x_new).abs == (y_position - y_new).abs
#       true
#     else
#       super
#     end
#   end
# end
class Bishop < Piece
  def valid_move?(x_new, y_new)
    super && obstructed?(x_new, y_new) && ((x_position - x_new).abs == (y_position - y_new).abs)
  end
end
