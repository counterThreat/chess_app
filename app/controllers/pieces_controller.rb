class PiecesController < ApplicationController
  # def index
  #  @game = Game.find(params[:game_id])
  #  @pieces = @game.pieces
  #  render json: @pieces
  # end

  # def create
  #   @pieces = current_game.pieces.create(piece_params)
  # end

  def show
    @pieces = current_game.pieces.order(:y_position).order(:x_position).to_a
  end

  def update
    # @piece = current_game.where(params[:piece_id])
    # current_piece
    # x = params[:x_position]
    # y = params[:y_position]

    if true
      redirect_to current_piece.game
    else
      render text: 'nope', status: :forbidden
    end

    # @pieces.first
  #   relationship = @game.relationships.where(:piece_id => @piece.id)
    # relationship.update(attributes(:x_position => x, :y_position => y, :updated_at => Time.now))

    # redirect_to current_piece.game
  ##   if @piece && x.present? && y.present?
  ##    @piece.update_attributes(x_position: x, y_position: y, updated_at: Time.now)
  ##  end

   # render json: {
  #     update_url: game_path(@game)
    # }
  end

  def current_game
    @game ||= current_piece.game
  end

  def current_piece
    @piece ||= Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :type, :color, :game_id, :user_id, :captured)
  end
end
