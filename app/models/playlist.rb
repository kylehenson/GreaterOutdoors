class Playlist

  def self.service
    @service ||= EchonestService.new
  end

  def self.create_playlist(min_tempo, max_tempo, song_count)
    playlist = Playlist.service.fetch_playlist(min_tempo, max_tempo, song_count)
    params = PlaylistParser.parse(playlist)
    Playlist.create(params)
  end

end
