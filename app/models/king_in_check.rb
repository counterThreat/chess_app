




def check(color)
 +    king = pieces.find_by(type: 'King', color: color)
 +    opponents = pieces.where.not(color: color)
 +    opponents.each do |opponent|
 +      return king.color if opponent.valid_move?(king.x_position, king.y_position)
 +    end
    
    def move_causes_check?(x, y)
    state = false
    ActiveRecord::Base.transaction do
      change_location(x,y)
      state = game.in_check?(color)
      raise ActiveRecord::Rollback
    end
    reload
    state
  end