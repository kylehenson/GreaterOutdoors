require 'rails_helper'

RSpec.describe EchonestService, type: :model do

  it "returns list of tracks with no Spotify taste found" do
    VCR.use_cassette("echonest_service#fetch_tracks") do
      results = EchonestService.fetch_tracks("100", "125", "20")

      expect(results.count).to eq 20
      expect(results.first.artist).to eq "Nickelback"
      expect(results.first.title).to eq "She Keeps Me Up"
      expect(results.first.tempo).to eq "100.0"
      expect(results.first.duration).to eq "237.66667"
      expect(results.first.spotify_track_id).to eq "spotify:track:54nor0Y8PVikN7EbRkQXNS"
    end
  end

  it "returns list of tracks with Spotify taste found" do
    VCR.use_cassette("echonest_service#fetch_playlist") do
      results = EchonestService.fetch_playlist("100", "125", "30", "spotify:track:12HB8AmFTovKrFcGG36KbL")

      expect(results.count).to eq 30
      expect(results.first.artist).to eq "Florence + The Machine"
      expect(results.first.title).to eq "Bedroom Hymns"
      expect(results.first.tempo).to eq "106.001"
      expect(results.first.duration).to eq "182.56621"
      expect(results.first.spotify_track_id).to eq "spotify:track:5tMNfvZZTSmeterYKXYjdL"
    end
  end
end
