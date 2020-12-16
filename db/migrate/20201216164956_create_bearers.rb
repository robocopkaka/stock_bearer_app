class CreateBearers < ActiveRecord::Migration[6.0]
  def change
    enable_extension :citext
    create_table :bearers do |t|
      t.citext :name

      t.timestamps
    end
    
    add_index :bearers, :name, unique: true
  end
end
