class PlaylistsController < ApplicationController

  def index
    
  end

  def new

  end

  def create
    @playlist = Playlist.new
    current_user.playlists << @playlist
    @playlist.fetch_tracks(params['activity'], params['time'])

    if @playlist.save
      @action = params['activity']
      @time = params['time']
      redirect_to playlists_path([@action, @time])
    else
      render :new
    end
  end
end
