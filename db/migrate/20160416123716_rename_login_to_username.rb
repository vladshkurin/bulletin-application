class RenameLoginToUsername < ActiveRecord::Migration
  def change
    rename_column :users, :login, :username
  end
end
