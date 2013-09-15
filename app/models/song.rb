class Song < ActiveRecord::Base
  attr_accessible :genre, :name, :song_id, :playlist_id
  belongs_to :playlist
end
