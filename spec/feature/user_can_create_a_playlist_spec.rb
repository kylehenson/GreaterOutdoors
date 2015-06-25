# require 'rails_helper'
#
# feature 'new playlist' do
#   let!(:user) { User.create(uid: "123",
#                             provider: "spotify",
#                             username: "Jack Nicholson")
#                             }
#
#   it 'creates a new playlist with valid parameters' do
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#     visit root_path
#     click_on "Get Started!"
#     expect(current_path).to eq new_playlist_path
#
#     within ("#activity") do
#       select("run - easy")
#     end
#     fill_in "time", with: "60"
#     fill_in "name", with: "60 minutes"
#     click_on "Create Playlist"
#
#     expect(current_path).to eq playlists_path
#     expect(page).to have_content "60 minutes"
#     expect(page).to have_content "Welcome, Jack Nicholson"
#   end
# end
