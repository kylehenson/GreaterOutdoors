class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :artist
      t.string :title
      t.string :tempo
      t.string :duration
      t.string :spotify_song_id
    end
  end
end
