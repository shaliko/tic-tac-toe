# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameMoveService do
  let(:game) { FactoryBot.create(:game) }

  describe '#move!' do
    context 'with a valid move' do
      it 'updates the game state' do
        service = GameMoveService.new(game:, row: 1, col: 1, player_token: game.player1_token)

        expect(service.move!).to be_truthy

        expect(game.reload.state['1']['1']).to eq(game.player1_symbol)
        expect(game.winner).to be_nil
      end

      it 'updates the game current_symbol after move' do
        service = GameMoveService.new(game:, row: 1, col: 1, player_token: game.player1_token)

        expect(service.move!).to be_truthy

        expect(game.reload.current_symbol).to eq(game.player2_symbol)
      end

      it 'updates the game winner after move' do
        game.state['0']['0'] = game.player1_symbol
        game.state['0']['1'] = game.player1_symbol
        game.save!
        service = GameMoveService.new(game:, row: 0, col: 2, player_token: game.player1_token)

        expect(service.move!).to be_truthy

        expect(game.reload.winner).to eq(game.player1_symbol)
      end

      it "updates the game winner as '=' on draw" do
        game.state['0']['0'] = game.player1_symbol
        game.state['0']['1'] = game.player2_symbol
        game.state['0']['2'] = game.player1_symbol
        game.state['1']['0'] = game.player2_symbol
        game.state['1']['1'] = game.player1_symbol
        game.state['1']['2'] = game.player2_symbol
        game.state['2']['0'] = game.player2_symbol
        game.state['2']['1'] = game.player1_symbol
        game.current_symbol = game.player2_symbol
        game.save!
        service = GameMoveService.new(game:, row: 2, col: 2, player_token: game.player2_token)

        expect(service.move!).to be_truthy

        expect(game.reload.winner).to eq('=')
      end
    end

    context 'with an invalid move' do
      context 'when game already finished' do
        it 'does not update the game state and returns error' do
          game.winner = game.player1_symbol
          game.save!
          service = GameMoveService.new(game:, row: 1, col: 1, player_token: game.player1_token)

          expect(service.move!).to be_falsy

          expect(service.game.errors.size).to eq(1)
          expect(service.game.errors[:base]).to include('Game already finished')
        end
      end

      context 'when wrong user turn' do
        it 'does not update the game state and returns error' do
          original_state = game.state
          service = GameMoveService.new(game:, row: 1, col: 1, player_token: game.player2_token)

          expect(service.move!).to be_falsy

          expect(service.game.errors.size).to eq(1)
          expect(service.game.errors[:base]).to include("It's not your turn")

          expect(original_state).to eq(game.reload.state)
        end
      end

      context 'when row and call out of boundaries' do
        it 'does not update the game state and returns error' do
          original_state = game.state
          service = GameMoveService.new(game:, row: 3, col: 3, player_token: game.player1_token)

          expect(service.move!).to be_falsy

          expect(service.game.errors.size).to eq(1)
          expect(service.game.errors[:base]).to include('Invalid move coordinates')

          expect(original_state).to eq(game.reload.state)
        end
      end

      context 'when row and call already taken' do
        it 'does not update the game state and returns error' do
          game.state['1']['1'] = game.player2_symbol
          game.save!
          original_state = game.state

          service = GameMoveService.new(game:, row: 1, col: 1, player_token: game.player1_token)

          expect(service.move!).to be_falsy

          expect(service.game.errors.size).to eq(1)
          expect(service.game.errors[:base]).to include('Invalid move coordinates, already taken')

          expect(original_state).to eq(game.reload.state)
        end
      end
    end
  end
end
