class PlaylistsController < ApplicationController

  def index
    @playlists = current_user.playlists
  end

  def new

  end

  def create
    track_uri = SpotifyService.new.grab_track(session[:token])
    @playlist = Playlist.new(playlist_params)

    @playlist.fetch_playlist(params['activity'], params['time'], track_uri)
    current_user.playlists << @playlist

    if @playlist.save
      flash[:success] = "Playlist successfully created."
      redirect_to playlists_path
    else
      flash.now[:danger] = @playlist.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def playlist_params
    params.permit(:name, :time)
  end
end
