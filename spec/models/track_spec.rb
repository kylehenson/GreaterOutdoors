require 'rails_helper'

RSpec.describe Track, type: :model do

  it 'is not valid without a title' do
    track = Track.new(title: nil)
    expect(track).not_to be_valid
  end

  it 'is not valid with an empty string for a title' do
    track = Track.new(title: '')
    expect(track).not_to be_valid
  end
  it 'is valid with a title' do
    track = Track.new(title: 'Dog Days are Over')
    expect(track).to be_valid
  end
end
