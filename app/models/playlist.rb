class Playlist < ActiveRecord::Base
  has_many :playlist_tracks
  has_many :tracks, through: :playlist_tracks

  has_many :user_playlists
  has_many :users, through: :user_playlists

  validates :name, presence: :true

  def fetch_tracks(activity, time)
    tempo_range = set_tempo_params(activity)
    track_count  = set_track_count_params(time)
    min_tempo   = tempo_range[:min_tempo]
    max_tempo   = tempo_range[:max_tempo]
    tracks       = EchonestService.fetch_tracks(min_tempo, max_tempo, track_count)

    tracks.each do |track|
      self.tracks << track rescue next
    end
  end

  def set_tempo_params(activity)
    if activity.include?("easy")
      {min_tempo: 100, max_tempo: 125}
    elsif activity.include?('moderate')
      {min_tempo: 126, max_tempo: 150}
    else
      {min_tempo: 151, max_tempo: 175}
    end
  end

  def set_track_count_params(time)
    (time.to_i/3.5*3).to_i
  end

end
