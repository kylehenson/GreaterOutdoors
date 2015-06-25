class SpotifyService
  attr_reader :connection

  def initialize
    offset = rand(1..10)
    @connection = Faraday.new("https://api.spotify.com/v1/me/tracks?market=US&limit=1&offset=#{offset}")
  end

  def grab_track(token)
    res = connection.get do |req|
      req.headers['Authorization'] = "Bearer #{token}"
    end
    JSON.parse(res.body)['items'].first['track']['uri'] rescue nil
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

end
