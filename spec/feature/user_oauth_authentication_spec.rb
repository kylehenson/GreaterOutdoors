require 'rails_helper'

def mock_auth_hash
  OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
    "provider" => "spotify",
    "uid" => "12345",
    "info" => {
      "name" => "Alexander",
      "email" => "dalex@hotmail.com",
      "image_url" => "image.jpg",
      },
    "credentials" => {
        "token" => "12345"
    }
  })
end

feature 'user logs in with Spotify' do
  scenario 'successfully' do
    visit root_path
    mock_auth_hash
    within (".home-text") do
      click_link "Log In with Spotify"
    end
    expect(page).to have_content "Log Out"
    expect(page).to have_content "Get Started!"
  end
end
