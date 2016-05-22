class CreateMatch < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :code
    end
  end
end
