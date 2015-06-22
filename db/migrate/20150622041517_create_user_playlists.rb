class CreateUserPlaylists < ActiveRecord::Migration
  def change
    create_table :user_playlists do |t|
      t.references :user
      t.references :playlist
      
      t.timestamps
    end
  end
end
