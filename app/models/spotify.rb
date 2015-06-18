class Spotify

  def self.service
    @service ||= SpotifyService.new
  end

end
