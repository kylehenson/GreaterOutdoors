class SpotifyService
  attr_reader :connection

  def initialize
    @connection = Faraday.new("https://api.spotify.com/v1")
  end

  def track(track_id)
    parse(connection.get("tracks/#{track_id}"))
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

end
