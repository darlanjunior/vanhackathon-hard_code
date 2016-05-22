class CreateMatch < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end
