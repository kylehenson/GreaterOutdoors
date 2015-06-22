class User < ActiveRecord::Base
  has_many :user_playlists
  has_many :playlists, through: :user_playlists

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(
            provider: auth.provider,
            uid:      auth.uid
            )

    user.provider  = auth.provider
    user.uid       = auth.uid
    user.username  = auth.info.name
    user.email     = auth.info.email
    user.image_url = auth.info.image
    user.token     = auth.credentials.token
    user.save

    user
  end

end
