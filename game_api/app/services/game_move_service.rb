class GameMoveService
  attr_reader :game

  def initialize(game: , row: , col:, player_token:)
    @game = game
    @row = row.to_s
    @col = col.to_s
    @player_token = player_token
  end

  def move!
    return false unless valid_move?

    @game.state[@row][@col] = player_symbol
    @game.current_symbol = ::Game::GAME_SYMBOLS[0] == @game.current_symbol ? ::Game::GAME_SYMBOLS[1] : ::Game::GAME_SYMBOLS[0]
    @game.save!

    return true
  end

  private

  def player_symbol
    if @game.player1_token == @player_token
      @game.player1_symbol
    elsif @game.player2_token == @player_token
      @game.player2_symbol
    else
      raise "Invalid player token"
    end
  end

  def valid_move?
    check_boundaries
    check_current_symbol
    check_coordinates

    @game.errors.blank?
  end

  def check_boundaries
    return unless @row.to_i < 0 || @row.to_i > 2 || @col.to_i < 0 || @col.to_i > 2
    
    @game.errors.add(:base, "Invalid move coordinates")
  end

  def check_current_symbol
    return if @game.current_symbol == player_symbol

    @game.errors.add(:base, "It's not your turn")
  end

  def check_coordinates
    return if @game.state.dig(@row, @col).blank?

    @game.errors.add(:base, "Invalid move coordinates, already taken")
  end
end
