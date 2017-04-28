module PiecesHelper
  def draw_square(x_axis, y_axis)
    selected_piece = square_piece(x_axis, y_axis)
    link_to piece_path(id: @current_piece, piece: { x_position: x_axis, y_position: y_axis }), # , game_id: @game.id
      method: 'POST',
      class: "#{'selected' if selected?(selected_piece)}" do
        content_tag :div, class: "square square--#{background_color(x_axis, y_axis)}" do
          selected_piece
        end
    end
  end

  def background_color(x_axis, y_axis)
    if x_axis.odd? && y_axis.odd? || x.axis.even? && y_axis.even?
      'white'
    else
      'grey'
    end
  end

  def square_piece(x_axis, y_axis)
    piece = @pieces.first
    return @pieces.shift if piece && piece.x_position == x_axis && piece.y_position == y_axis
  end

  def selected?(selected_piece)
    selected_piece == @current_piece
  end
end
