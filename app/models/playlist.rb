class Playlist < ActiveRecord::Base

  attr_accessor :playlist_url
  has_many :songs
  accepts_nested_attributes_for :songs

  def create_playlist(songs)
  	self.playlist_url = "http://www.google.com"
  end

  def self.as_json_options(options={})
    options ||= {}
    options[:methods] ||= []
    options[:methods].concat [:playlist_url]
    options
  end

  def as_json(options={})
    super(Playlist.as_json_options)
  end
end
