module GamesHelper
  def display_date(input_date)
    input_date.strftime('%B %d %Y')
  end

  def draw_square(x_axis, y_axis)
    content_tag :div,
                class: "square square--#{background_color(x_axis, y_axis)}",
                data: { x: x_axis, y: y_axis } do
                  draw_piece(x_axis, y_axis)
                end
  end

  def draw_piece(x_axis, y_axis)
    selected_piece = square_piece(x_axis, y_axis)
    return unless selected_piece
    link_to piece_path(selected_piece), data: { id: selected_piece.id }
  end
end
