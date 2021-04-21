class CreateJoinTableGenreSeriee < ActiveRecord::Migration[6.1]
  def change
    create_join_table :genres, :seriees do |t|
      t.index [:genre_id, :seriee_id]
      t.index [:seriee_id, :genre_id]
    end
  end
end
