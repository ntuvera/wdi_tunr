class SongsController < ApplicationController

  def search
    @songs = Song.itunes_search(params[:search_term])
  end

  def save
    new_song = Song.itunes_lookup(params[:track_id])
    new_song.save
    @current_listener.songs << new_song
    redirect_to root_path
  end

  def destroy
    Song.delete(params[:id])
    redirect_to root_path
  end
end
