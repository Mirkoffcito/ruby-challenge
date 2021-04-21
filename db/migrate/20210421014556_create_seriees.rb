class CreateSeriees < ActiveRecord::Migration[6.1]
  def change
    create_table :seriees do |t|
      t.string :title
      t.string :image_data
      t.date :date_released
      t.integer :seasons
      t.integer :score
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
