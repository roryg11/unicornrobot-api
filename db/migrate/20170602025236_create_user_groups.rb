class CreateUserGroups < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :integer, :null => false, :default => 1
    create_table :user_groups do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
