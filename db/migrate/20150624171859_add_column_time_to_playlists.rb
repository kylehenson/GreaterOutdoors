class AddColumnTimeToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :time, :string
  end
end
