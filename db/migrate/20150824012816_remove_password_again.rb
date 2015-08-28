class RemovePasswordAgain < ActiveRecord::Migration
  def change
    add_column(:users, :password, :text)
    remove_column(:users, :password)
  end
end
