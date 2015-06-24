require 'rails_helper'

RSpec.describe Playlist, type: :model do

  it 'is not valid without a name' do
    playlist = Playlist.new(name: nil)
    expect(playlist).not_to be_valid
  end

  it 'is not valid with an empty string for a name' do
    playlist = Playlist.new(name: '')
    expect(playlist).not_to be_valid
  end

  it 'is not valid without a time' do
    playlist = Playlist.new(time: nil)
    expect(playlist).not_to be_valid
  end

  it 'is not valid with an empty string for a time' do
    playlist = Playlist.new(time: '')
    expect(playlist).not_to be_valid
  end

  it 'is valid with a name and time' do
    playlist = Playlist.new(name: "running", time: "4")
    expect(playlist).to be_valid
  end

  xit 'returns a list of tracks for a playlist with easy activity and short time' do
    playlist = Playlist.new(name: "Friday")
    result = playlist.fetch_tracks("hike - easy", "10")
    expect(result.first.class).to eq Track
  end

  xit 'returns a list of tracks for a playlist with hard activity and long time' do
    playlist = Playlist.new(name: "Saturday")
    result = playlist.fetch_tracks("hike - hard", "115")
    expect(result.first.class).to eq Track
  end

  it 'sets tempo params based on easy activity' do
    playlist = Playlist.new(name: "Slow")
    result = playlist.set_tempo_params('run - easy')
    expect(result).to eq({:min_tempo=>100, :max_tempo=>125})
  end

  it 'sets tempo params based on moderate activity' do
    playlist = Playlist.new(name: "In the middle")
    result = playlist.set_tempo_params('run - moderate')
    expect(result).to eq({:min_tempo=>126, :max_tempo=>150})
  end

  it 'sets tempo params based on hard activity' do
    playlist = Playlist.new(name: "Fast")
    result = playlist.set_tempo_params('run - hard')
    expect(result).to eq({:min_tempo=>151, :max_tempo=>175})
  end

  it 'sets track count params based on short time' do
    playlist = Playlist.new(name: "Short")
    result = playlist.set_track_count_params("15")
    expect(result).to eq 12
  end

  it 'sets track count params based on long time' do
    playlist = Playlist.new(name: "For Ever")
    result = playlist.set_track_count_params("180")
    expect(result).to eq 154
  end

end
