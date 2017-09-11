class AddDeleteToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :deleted, :boolean, null: false, default: false
    add_column :requirements, :deleted, :boolean, null: false, default: false
    add_column :comments, :deleted, :boolean, null: false, default: false
    add_column :users, :deleted, :boolean, null: false, default: false
  end
end
