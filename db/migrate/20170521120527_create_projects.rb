class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :client
      t.date :start_date
      t.date :finish_date
      t.string :status

      t.timestamps
    end

    add_index :projects, :name

    create_join_table :Users, :Projects do |t|
      t.index [:user_id, :project_id]
      t.index [:project_id, :user_id]
    end
  end
end
