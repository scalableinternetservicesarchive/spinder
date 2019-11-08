class CreateSongInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :song_infos do |t|
      t.string :song_id
      t.string :name
      t.string :artist
      t.string :image_url

      t.timestamps
    end
  end
end
