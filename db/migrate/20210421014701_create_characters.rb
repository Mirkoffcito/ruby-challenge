class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :image_data
      t.integer :age
      t.integer :weight_kg
      t.string :history
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
