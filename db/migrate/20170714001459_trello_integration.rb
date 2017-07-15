class TrelloIntegration < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :trello_board_id, :string
    add_column :projects, :trello_list_id, :string

    create_table :tasks do |t|
      t.belongs_to :requirement, index: true
      t.string :trello_task_id
      t.timestamps
    end
  end
end
