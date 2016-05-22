class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.string :colors
      t.integer :near
      t.integer :exact
      t.references :user

      t.timestamps null: false
    end
  end
end
