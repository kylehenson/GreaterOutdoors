class PlaylistsController < ApplicationController

  def index

  end

  def new

  end

  def create
    @playlist = Playlist.create_playlist()
  end
end
