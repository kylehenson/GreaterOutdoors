module EchonestService

  def self.fetch_tracks(min_tempo, max_tempo, track_count)
    response = fetch_tracks!(min_tempo, max_tempo, track_count)
    collect_tracks(response['response']['songs'])
  end

  def self.collect_tracks(tracks)
    tracks.collect do |track|
      artist          = track['artist_name']
      title           = track['title']
      tempo           = track['audio_summary']['tempo']
      duration        = track['audio_summary']['duration']
      spotify_track_id = track['tracks'].first['foreign_id'].split(":").last
      Track.new(artist: artist, title: title, tempo: tempo, duration: duration, spotify_track_id: spotify_track_id)
    end
  end

  def self.fetch_tracks!(min_tempo, max_tempo, track_count)
    connection = Faraday.new("http://developer.echonest.com")
    connection.options.params_encoder = Faraday::FlatParamsEncoder
    response = connection.get do |req|
      req.url('/api/v4/song/search')
      req.params['api_key'] = ENV['ECHONEST_API_KEY']
      req.params['format'] = 'json'
      req.params["song_min_hotttnesss"] = ".5"
      req.params["min_tempo"] = "#{min_tempo}"
      req.params["max_tempo"] = "#{max_tempo}"
      req.params["sort"] = "tempo-asc"
      req.params["results"] = "#{track_count}"
      req.params['bucket'] = ['audio_summary', 'id:spotify', 'tracks']
      req.params['limit'] = true
    end

    JSON.parse(response.body)
  end
end
