# frozen_string_literal: true

class AddWinnerColumnToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :winner, :string, limit: 1
  end
end
