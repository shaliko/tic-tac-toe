class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.json :state
      t.string :player1_token
      t.string :player2_token
      t.string :initial_symbol, limit: 1

      t.timestamps
    end
  end
end
