# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameMoves API', type: :request do
  let(:game) { FactoryBot.create(:game) }

  describe 'POST /api/games/:game_id/moves' do
    context 'with a valid move' do
      let(:valid_params) do
        {
          row: rand(3).to_s,
          col: rand(3).to_s,
          player_token: game.player1_token
        }
      end

      it 'creates a new move' do
        # Validate that GameMoveService was called with specific params
        expect(GameMoveService).to receive(:new).with(
          game:,
          row: valid_params[:row],
          col: valid_params[:col],
          player_token: game.player1_token
        ).and_call_original

        post api_game_moves_path(game), params: valid_params

        expect(response).to have_http_status(201)
      end

      it 'responses with game model' do
        post api_game_moves_path(game), params: valid_params

        expect(response).to have_http_status(201)

        game.reload
        expect(json_response).to eq(game.as_json)
      end
    end

    context 'with an invalid move' do
      context 'when row param missed' do
        let(:invalid_params) do
          {
            col: rand(3).to_s,
            player_token: game.player1_token
          }
        end

        it 'returns status code 400 and error message' do
          post api_game_moves_path(game), params: invalid_params

          expect(response).to have_http_status(400)

          expect(json_response).to eq({
                                        'error' => { 'message' => 'param is missing or the value is empty: row',
                                                     'type' => 'ParameterMissing' }
                                      })
        end
      end

      context 'when col param missed' do
        let(:invalid_params) do
          {
            row: rand(3).to_s,
            player_token: game.player1_token
          }
        end

        it 'returns status code 400 error message' do
          post api_game_moves_path(game), params: invalid_params

          expect(response).to have_http_status(400)

          expect(json_response).to eq({
                                        'error' => { 'message' => 'param is missing or the value is empty: col',
                                                     'type' => 'ParameterMissing' }
                                      })
        end
      end

      context 'when col param missed' do
        let(:invalid_params) do
          {
            row: rand(3).to_s,
            col: rand(3).to_s
          }
        end

        it 'returns status code 400 error message' do
          post api_game_moves_path(game), params: invalid_params

          expect(response).to have_http_status(400)

          expect(json_response).to eq({
                                        'error' => {
                                          'message' => 'param is missing or the value is empty: player_token', 'type' => 'ParameterMissing'
                                        }
                                      })
        end
      end

      context 'when wrong user turn' do
        let(:invalid_params) do
          {
            row: rand(3).to_s,
            col: rand(3).to_s,
            player_token: game.player2_token # first turn is for player1
          }
        end

        it 'returns status code 422 and error message' do
          post api_game_moves_path(game), params: invalid_params

          expect(response).to have_http_status(422)

          expect(json_response).to eq({
                                        'error' => { 'message' => 'Validation failed', 'type' => 'ValidationError',
                                                     'details' => ["It's not your turn"] }
                                      })
        end
      end
    end
  end

  # Helper method to parse the response body to JSON
  def json_response
    JSON.parse(response.body)
  end
end
