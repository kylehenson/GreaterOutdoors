class Playlists::SpotifyController < ApplicationController
  require 'base64'

  def create
    current_user.playlists.find(params[:id])
    user_id = current_user.uid
    connection = Faraday.new("https://api.spotify.com/v1/users/#{user_id}/playlists")
    # jwt = Base64.encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_SECRET']}")
    res = connection.post do |req|
      req.headers['Authorization'] = "Bearer #{session[:token]}"
      req.body = '{ "name": "New Playlist", "public": false }'
    end
    if response.success?
      playlist_id = JSON.parse(res.body)['uri'].split(':').last
      connection = Faraday.new("https://api.spotify.com/v1/users/#{user_id}/playlists/#{playlist_id}/tracks")
      res = connection.post do |req|
        req.headers['Authorization'] = "Bearer #{session[:token]}"
        req.params['uris'] = Playlist.find(params[:id]).tracks.map(&:spotify_track_id).join(",")
      end
      # flash
      redirect_to playlists_path
    elsif response.status == 401
      session.clear
      redirect_to login_path
    else
      # flash
      redirect_to playlists_path
  end

end


# 401 is status code for redirect from Spotify

__END__
/v1/users/1229989329/playlists
{
  "collaborative" : false,
  "description" : null,
  "external_urls" : {
    "spotify" : "http://open.spotify.com/user/1229989329/playlist/3mPyPq71wG3EJuzCpNu4t6"
  },
  "followers" : {
    "href" : null,
    "total" : 0
  },
  "href" : "https://api.spotify.com/v1/users/1229989329/playlists/3mPyPq71wG3EJuzCpNu4t6",
  "id" : "3mPyPq71wG3EJuzCpNu4t6",
  "images" : [ ],
  "name" : "New Playlist",
  "owner" : {
    "external_urls" : {
      "spotify" : "http://open.spotify.com/user/1229989329"
    },
    "href" : "https://api.spotify.com/v1/users/1229989329",
    "id" : "1229989329",
    "type" : "user",
    "uri" : "spotify:user:1229989329"
  },
  "public" : false,
  "snapshot_id" : "EEB3TZt//j/XGxz4OB8CmNVHUJRwPRifQu6MaEyUjpZ6YZzpNHgZfKW8fWkePTJ/",
  "tracks" : {
    "href" : "https://api.spotify.com/v1/users/1229989329/playlists/3mPyPq71wG3EJuzCpNu4t6/tracks",
    "items" : [ ],
    "limit" : 100,
    "next" : null,
    "offset" : 0,
    "previous" : null,
    "total" : 0
  },
  "type" : "playlist",
  "uri" : "spotify:user:1229989329:playlist:3mPyPq71wG3EJuzCpNu4t6"
}
