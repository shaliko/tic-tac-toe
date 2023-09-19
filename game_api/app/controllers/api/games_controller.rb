class Api::GamesController < ApplicationController
  def create
    game = Game.new
    
    if @game.save
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  def show
    game = Game.find(params[:id])
    render json: game
  end
end
