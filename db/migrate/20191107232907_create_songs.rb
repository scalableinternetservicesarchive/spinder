class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :user_email
      t.string :song_id

      t.timestamps
    end
  end
end
