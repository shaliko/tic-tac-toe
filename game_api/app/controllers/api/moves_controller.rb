class Api::MovesController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    game_move_service = GameMoveService.new(
      game: game,
      row: game_move_params[:row],
      col: game_move_params[:col],
      player_token: game_move_params[:player_token]
    )

    if game_move_service.move!
      render json: game_move_service.game, status: :created
    else
      render json: { error: { message: 'Validation failed', type: 'ValidationError', details: game_move_service.game.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  private

  def game_move_params
    params.require(:row)
    params.require(:col)
    params.require(:player_token)
    params.permit(:row, :col, :player_token)
  end
end
