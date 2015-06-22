class PlaylistParser

  def self.parse(track)
    params = {}
    params[:artist_name] = track['artist_name']
    params[:title] = track['title']
    params[:tempo] = track['audio_summary']['tempo']
    params[:duration] = track['audio_summary']['duration']
    params
  end
end
