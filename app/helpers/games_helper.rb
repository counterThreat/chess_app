module GamesHelper
  def display_date(input_date)
    input_date.strftime('%B %d %Y')
  end
  
  def can_forfeit?(game)
    return false unless game.winning_player_id.nil?
    return false unless game.white_player.present? && game.black_player.present?
    game.white_player == current_user || game.black_player == current_user
  end
end
