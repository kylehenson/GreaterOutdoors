class PlaylistsController < ApplicationController

  def index

  end

  def new

  end

  def create
    @playlist = Playlist.new
    current_user.playlists << @playlist
    @playlist.fetch_songs(params['activity'], params['time'])

    if @playlist.save
      redirect_to playlists_path
    else
      render :new
    end
  end
end
