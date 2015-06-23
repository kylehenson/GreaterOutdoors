class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :tracks, :spotify_song_id, :spotify_track_id
  end
end
