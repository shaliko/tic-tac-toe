require 'rails_helper'

RSpec.describe GameMoveService do
  let(:game) { FactoryBot.create(:game) }
  
  describe '#move!' do
    context 'with a valid move' do
      it 'updates the game state' do
        service = GameMoveService.new(game: game, row: 1, col: 1, player_token: game.player1_token)

        expect(service.move!).to be_truthy

        expect(game.reload.state['1']['1']).to eq(game.player1_symbol)
      end

      it 'updates the game current_symbol after move' do
        service = GameMoveService.new(game: game, row: 1, col: 1, player_token: game.player1_token)

        expect(service.move!).to be_truthy

        expect(game.reload.current_symbol).to eq(game.player2_symbol)
      end
    end

    context 'with an invalid move' do
      context 'when wrong user turn' do
        it 'does not update the game state and returns error' do
          original_state = game.state
          service = GameMoveService.new(game: game, row: 1, col: 1, player_token: game.player2_token)

          expect(service.move!).to be_falsy

          expect(service.game.errors.size).to eq(1)
          expect(service.game.errors[:base]).to include("It's not your turn")

          expect(original_state).to eq(game.reload.state)
        end
      end

      context 'when row and call out of boundaries' do
        it 'does not update the game state and returns error' do
          original_state = game.state
          service = GameMoveService.new(game: game, row: 3, col: 3, player_token: game.player1_token)

          expect(service.move!).to be_falsy

          expect(service.game.errors.size).to eq(1)
          expect(service.game.errors[:base]).to include("Invalid move coordinates")

          expect(original_state).to eq(game.reload.state)
        end
      end

      context 'when row and call already taken' do
        it 'does not update the game state and returns error' do
          game.state['1']['1'] = game.player2_symbol
          game.save!
          original_state = game.state

          service = GameMoveService.new(game: game, row: 1, col: 1, player_token: game.player1_token)

          expect(service.move!).to be_falsy

          expect(service.game.errors.size).to eq(1)
          expect(service.game.errors[:base]).to include("Invalid move coordinates, already taken")

          expect(original_state).to eq(game.reload.state)
        end
      end
    end
  end
end