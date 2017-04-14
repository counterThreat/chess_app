class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def on_board?
    if x_position >= 0 && x_position <= 7 && y_position >= 0 && y_position <= 7
      true
    else
      false
    end
  end

  def move(x_new, y_new)
    if obstructed?(x_new, y_new)
      puts 'Your path is blocked!'
      return
    end
    if valid_move?(x_new, y_new) && on_board?
      empty_previous
      self.x_position = x_new
      self.y_position = y_new
    else
      puts 'Move is not allowed!'
    end
  end

  def empty_previous
    x_old = x_position
    y_old = y_position
    array[x_old][y_old] = 0
  end

  def obstructed?(x_new, y_new) # Integrate with color
    # The following two lines determine if the differences between x to x_new
    # and y to y_new are positive, negative, or zero. This is used to iterate in
    # the correct direction below when looking at each square in the piece's path.
    xdir = x_position < x_new ? 1 : ((x_position == x_new ? 0 : -1))
    ydir = y_position < y_new ? 1 : ((y_position == y_new ? 0 : -1))
    i = 1
    dx = (x_new - x_position).abs
    dy = (y_new - y_position).abs
    until i - 1 == [dx, dy].max
      # puts "#{self.x+i*xdir},#{self.y+i*ydir}"
      if array[x_position + i * xdir][y_position + i * ydir] != 0
        return true
      end
      i += 1
    end
  end
end
