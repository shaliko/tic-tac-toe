# frozen_string_literal: true

# GameMoveService for creating moves
# Validates and update Game model
class GameMoveService
  attr_reader :game

  def initialize(game:, row:, col:, player_token:)
    @game = game
    @row = row.to_s
    @col = col.to_s
    @player_token = player_token
  end

  def move!
    return false unless valid_move?

    @game.state[@row][@col] = player_symbol
    @game.current_symbol = ::Game::SYMBOLS[0] == @game.current_symbol ? ::Game::SYMBOLS[1] : ::Game::SYMBOLS[0]
    @game.winner = winner
    @game.save
  end

  private

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def winner
    state = @game.state

    # Check rows & columns
    3.times do |index|
      i = index.to_s
      return state[i]['0'] if state[i]['0'] == state[i]['1'] && state[i]['1'] == state[i]['2'] && state[i]['0'].present?
      return state['0'][i] if state['0'][i] == state['1'][i] && state['1'][i] == state['2'][i] && state['0'][i].present?
    end

    # Check diagonals
    if state['0']['0'] == state['1']['1'] && state['1']['1'] == state['2']['2'] && state['0']['0'].present?
      return state['0']['0']
    end
    if state['0']['2'] == state['1']['1'] && state['1']['1'] == state['2']['0'] && state['0']['2'].present?
      return state['0']['2']
    end

    return '=' if state.values.none? { |row| row.values.include?(nil) }

    # no winner
    nil
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def player_symbol
    if @game.player1_token == @player_token
      @game.player1_symbol
    elsif @game.player2_token == @player_token
      @game.player2_symbol
    else
      raise 'Invalid player token'
    end
  end

  def valid_move?
    check_game_ended
    check_boundaries
    check_current_symbol
    check_coordinates

    @game.errors.blank?
  end

  def check_game_ended
    return unless @game.winner.present?

    @game.errors.add(:base, 'Game already finished')
  end

  def check_boundaries
    return unless @row.to_i.negative? || @row.to_i > 2 || @col.to_i.negative? || @col.to_i > 2

    @game.errors.add(:base, 'Invalid move coordinates')
  end

  def check_current_symbol
    return if @game.current_symbol == player_symbol

    @game.errors.add(:base, "It's not your turn")
  end

  def check_coordinates
    return if @game.state.dig(@row, @col).blank?

    @game.errors.add(:base, 'Invalid move coordinates, already taken')
  end
end
