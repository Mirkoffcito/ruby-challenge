class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :image_data
      t.date :date_released
      t.integer :score
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
