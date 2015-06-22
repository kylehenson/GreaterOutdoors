class Playlist < ActiveRecord::Base
  has_many :playlist_tracks
  has_many :tracks, through: :playlist_tracks

  has_many :user_playlists
  has_many :users, through: :user_playlists

  def fetch_songs(activity, time)
    tempo_range = set_tempo_params(activity)
    song_count  = set_song_count_params(time)
    min_tempo   = tempo_range[:min_tempo]
    max_tempo   = tempo_range[:max_tempo]
    songs       = EchonestService.fetch_songs(min_tempo, max_tempo, song_count)

    songs.each do |song|
      self.tracks << song
    end
    #playlist['response']['songs'].uniq! { |song| song['title'].downcase }

    # Create track objects from each song, validating uniqeness and saving things
      # like tempo, play time, spotify_id, artist, title, image-url
    # playlist['response']['songs'].each do |track|
    #   params = PlaylistParser.parse(track)
    #   Track.new(params)
    # end
    # Then create playlist by calling a random list of songs from personal database
      # and checking that the tempo matches and length ~ time

    # create_playlist
  end
    # Playlist.create(params)

  def set_tempo_params(activity)
    if activity.include?("easy")
      {min_tempo: 100, max_tempo: 125}
    elsif activity.include?('moderate')
      {min_tempo: 126, max_tempo: 150}
    else
      {min_tempo: 151, max_tempo: 175}
    end
  end

  def set_song_count_params(time)
    (time.to_i/3.5*3).to_i
  end

end
