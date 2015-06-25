class Playlists::SpotifyController < ApplicationController
  require 'base64'

  def create
    playlist = current_user.playlists.find(params[:id])
    user_id = current_user.uid
    connection = Faraday.new("https://api.spotify.com/v1/users/#{user_id}/playlists")
    res = connection.post do |req|
      req.headers['Authorization'] = "Bearer #{session[:token]}"
      req.body = '{ "name": "' + playlist.name + '", "public": false }'
    end
    if res.success?
      playlist_id = JSON.parse(res.body)['uri'].split(':').last
      connection = Faraday.new("https://api.spotify.com/v1/users/#{user_id}/playlists/#{playlist_id}/tracks")
      res = connection.post do |req|
        req.headers['Authorization'] = "Bearer #{session[:token]}"
        req.params['uris'] = Playlist.find(params[:id]).tracks.map(&:spotify_track_id).join(",")
      end
      flash[:success] = "Playlist added to your Spotify account!"
      redirect_to playlists_path
    elsif res.status == 401
      flash.now[:danger] = "Session timed out. Please log in."
      session.clear
      redirect_to login_path
    else
      flash.now[:danger] = "Something's wrong. Try again later."
      redirect_to playlists_path
    end
  end

end
