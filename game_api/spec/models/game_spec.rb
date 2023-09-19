require 'rails_helper'

RSpec.describe Game, type: :model do
  it "is valid with initial state" do
    game = FactoryBot.build(:game)
    expect(game).to be_valid
  end
end