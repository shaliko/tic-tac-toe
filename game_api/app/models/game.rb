# frozen_string_literal: true

# Game model with validations and initial state
class Game < ApplicationRecord
  SYMBOLS = %w[x o].freeze

  before_validation :initial_state, on: :create

  private

  def initial_state
    self.state = {
      0 => { 0 => nil, 1 => nil, 2 => nil },
      1 => { 0 => nil, 1 => nil, 2 => nil },
      2 => { 0 => nil, 1 => nil, 2 => nil }
    }
    self.current_symbol = SYMBOLS.sample
    self.player1_symbol = current_symbol
    self.player2_symbol = SYMBOLS[0] == current_symbol ? SYMBOLS[1] : SYMBOLS[0]
    self.player1_token = SecureRandom.urlsafe_base64
    self.player2_token = SecureRandom.urlsafe_base64
  end
end
