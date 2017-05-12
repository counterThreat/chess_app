class PiecesController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    @pieces = Piece.where(game_id: @game.id)
    # @game = Game.find(params[:game_id])
    render json: @pieces
  end

  # def create
  #  @pieces = current_game.pieces.create(piece_params)
  # end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    x = piece_params[:x_position]
    y = piece_params[:y_position]
    if your_turn
      render text: 'It is your turn'
            #  status: :unauthorized
    else
      current_piece.update_attributes(x_position: x, y_position: y, updated_at: Time.now) if current_piece && x.present? && y.present?
      self.game.turn = (self.game.turn == self.game.white_player_id) ? self.game.black_player_id : self.game.white_player_id
      self.game.save!

      if (self.game.turn == self.game.white_player_id)
        self.game.turn = self.game.black_player_id
      else
        self.game.turn = self.game.white_player_id
      end

      self.game.save!
      render json: { status: :ok } && return if request.xhr?
      redirect_to current_piece.game
    end
  end

  def current_game
    @game ||= current_piece.game
  end

  def current_piece
    @piece ||= Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :color, :game_id, :user_id, :captured, :move_num)
  end

  def url_status
    return :ok if try_success?
    :forbidden
  end

  def your_turn
    current_game.turn == current_user
  end
end
