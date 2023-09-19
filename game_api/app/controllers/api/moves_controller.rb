class Api::MovesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    game_move_service = GameMoveService.new(
      game: @game,
      row: game_move_params[:row],
      col: game_move_params[:col],
      player_token: game_move_params[:player_token]
    )

    if game_move_service.move!
      render json: game_move_service.game, status: :created
    else
      render json: game_move_service.game.errors, status: :unprocessable_entity
    end

    render json: @game
  end

  private

  def game_move_params
    params.permit(:row, :col, :player_token)
  end
end
