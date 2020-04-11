class AddApiUidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gh_login, :string
    add_column :users, :so_uid, :string
  end
end
