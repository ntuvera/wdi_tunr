class Song < ActiveRecord::Base

  has_and_belongs_to_many :listeners

  def self.itunes_search(query)
    escaped_query = query.downcase.gsub(' ','+')
    query_string = "entity=musicTrack&limit=20&term=#{escaped_query}"
    url = "http://itunes.apple.com/search?#{query_string}"
    raw_response = HTTParty.get(url)
    response = JSON.parse(raw_response)
    raw_songs = response['results']
    package_songs = raw_songs.map do |song|
      {
        :itunes_artist_id => song['artistId'],
        :itunes_song_id => song['trackId'],
        :title => song['trackName'],
        :artwork_url => song['artworkUrl100']
      }
    end
    package_songs
  end


  def self.itunes_lookup(id)
    url = "http://itunes.apple.com/lookup?id=#{id}"
    raw_response = HTTParty.get(url)
    response = JSON.parse(raw_response)
    raw_song = response['results'].first

    song_hash = {
      title: raw_song['trackName'],
      album: raw_song["collectionname"],
      genre: raw_song["primaryGenreName"],
      preview_link:  raw_song['[reviewUrl'],
      artwork_url: raw_song['artworkUrl100']
    }

    Song.new(song_hash)
  end

  def destroy
    Song.delete(params[:id])
    redirect_to root_path
  end
end
