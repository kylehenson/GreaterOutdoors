class PlaylistsController < ApplicationController

  def index

  end

  def new

  end

  def create
    @playlist      = Playlist.new
    @playlist.name = params['name']
    current_user.playlists << @playlist
    @playlist.fetch_tracks(params['activity'], params['time'])

    if @playlist.save
      flash[:success] = "Playlist successfully created."
      redirect_to playlists_path
    else
      flash.now[:danger] = @playlist.errors.full_messages.join(", ")
      render :new
    end
  end
end
