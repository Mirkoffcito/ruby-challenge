class CreateJoinTableCharacterSeriee < ActiveRecord::Migration[6.1]
  def change
    create_join_table :characters, :seriees do |t|
      t.index [:character_id, :seriee_id]
      t.index [:seriee_id, :character_id]
    end
  end
end
