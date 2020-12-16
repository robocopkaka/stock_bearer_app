class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    enable_extension :citext
    create_table :stocks do |t|
      t.citext :name
      t.datetime :deleted_at
      t.references :bearer, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :stocks, :name, unique: true
  end
end
