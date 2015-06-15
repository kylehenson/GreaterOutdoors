class RemoveUid < ActiveRecord::Migration
  def change
    rename_column :users, :sid, :uid
  end
end
