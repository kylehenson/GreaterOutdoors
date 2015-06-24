class PlaylistsController < ApplicationController

  def index
    @playlists = current_user.playlists
  end

  def new

  end

  def create
    @playlist      = Playlist.new(playlist_params)
    @playlist.fetch_playlist(params['activity'], params['time'])
    # @playlist.fetch_tracks(params['activity'], params['time'])

    if @playlist.save
      UserPlaylist.create(user_id: current_user.id, playlist_id: playlist.id)
      flash[:success] = "Playlist successfully created."
      redirect_to playlists_path
    else
      flash.now[:danger] = @playlist.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :activity, :time)
  end
end
