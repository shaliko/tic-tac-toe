# frozen_string_literal: true

# Game model with validations and initial state
class Game < ApplicationRecord
  SYMBOLS = %w[x o].freeze
  WINNER_SYMBOLS = (SYMBOLS + ['=']).freeze

  before_validation :initial_state, on: :create

  validates :player1_token, :player2_token, presence: true

  validates :current_symbol, inclusion: { in: SYMBOLS, message: "must be either 'x' or 'o'" }
  validates :player1_symbol, inclusion: { in: SYMBOLS, message: "must be either 'x' or 'o'" }
  validates :player2_symbol, inclusion: { in: SYMBOLS, message: "must be either 'x' or 'o'" }

  validates :winner, inclusion: { in: WINNER_SYMBOLS, message: "must be either 'x', 'o' or '='" }, allow_nil: true

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
