# frozen_string_literal: true

module Api
  # GamesController for creating and showing game
  class GamesController < ApplicationController
    def create
      game = Game.new

      if game.save
        render json: game, status: :created
      else
        render json: {
                 error: {
                   message: 'Validation failed',
                   type: 'ValidationError',
                   details: game.errors.full_messages
                 }
               },
               status: :unprocessable_entity
      end
    end

    def show
      game = Game.find(params[:id])
      render json: game
    end
  end
end
