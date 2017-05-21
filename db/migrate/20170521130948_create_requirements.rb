class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.text :description
      t.string :sufix
      t.string :status
      t.string :category
      t.date :end_date

      t.timestamps
    end
  end
end
