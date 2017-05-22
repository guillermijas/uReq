class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string
    add_attachment :users, :avatar
    add_attachment :projects, :picture
  end
end
