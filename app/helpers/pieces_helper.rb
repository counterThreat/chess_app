module PiecesHelper
  def draw_square(x_axis, y_axis)
    selected_piece = square_piece(x_axis, y_axis)
    link_to piece_path(@game, piece: { x_position: x_axis, y_position: y_axis }), # game_id: @game.id
            method: 'PUT',
            class: ('selected' if selected?(selected_piece)).to_s do
      content_tag :div, class: "square square--#{background_color(x_axis, y_axis)}" do
        draw_piece(selected_piece)
      end
    end
  end

  def draw_piece(selected_piece)
    return unless selected_piece
    unicode = selected_piece.unicode.encode('utf-8')
    unicode
  end

  def background_color(x_axis, y_axis)
    if x_axis.odd? && y_axis.odd? || x_axis.even? && y_axis.even?
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
