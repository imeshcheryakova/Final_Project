class RemovePassword < ActiveRecord::Migration
  def change
    remove_column(:users, :pasword)
  end
end
