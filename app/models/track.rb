class Track < ActiveRecord::Base
  has_many :playlist_tracks
  has_many :playlists, through: :playlist_tracks

  # def initialize(data)
  #   @artist = data[:artist]
  #   @title = data[:title]
  #   @tempo = data[:tempo]
  #   @duration = data[:duration]
  #   @spotify_song_id = data[:spotify_song_id]
  # end

end
