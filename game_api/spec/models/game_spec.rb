# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'is valid with initial state' do
    game = FactoryBot.build(:game)
    expect(game).to be_valid
  end

  it 'is have valid state (all fileds are nil)' do
    game = FactoryBot.create(:game)
    expect(game.state.values.flat_map(&:values).all?(&:nil?)).to be_truthy
  end

  it 'is have current_symbol as player1' do
    game = FactoryBot.create(:game)

    expect(game.current_symbol).to eq(game.player1_symbol)
  end

  it 'is have player tokens' do
    game = FactoryBot.create(:game)

    expect(game.player1_token).to be_present
    expect(game.player2_token).to be_present
  end
end
