class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.json :state, null: false
      t.string :player1_token, null: false
      t.string :player2_token, null: false
      t.string :player1_symbol, limit: 1, null: false
      t.string :player2_symbol, limit: 1, null: false
      t.string :current_symbol, limit: 1, null: false

      t.timestamps
    end
  end
end
