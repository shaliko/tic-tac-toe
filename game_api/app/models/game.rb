class Game < ApplicationRecord
  GAME_SYMBOLS = %w[x o].freeze

  before_validation :initial_state, on: :create

  private

  def initial_state
    self.state = {
      0 => { 0 => nil, 1 => nil, 2 => nil },
      1 => { 0 => nil, 1 => nil, 2 => nil },
      2 => { 0 => nil, 1 => nil, 2 => nil }
    }
    self.initial_symbol = GAME_SYMBOLS.sample
    self.player1_token = SecureRandom.urlsafe_base64
    self.player2_token = SecureRandom.urlsafe_base64
  end
end
