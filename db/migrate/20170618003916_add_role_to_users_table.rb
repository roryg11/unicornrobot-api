class AddRoleToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :default => "Individual"
  end
end
