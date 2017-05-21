class CreateGlosarios < ActiveRecord::Migration[5.1]
  def change
    create_table :glosarios do |t|
      t.string :key, null: false
      t.string :definition
      t.timestamps
    end
    add_index :glosarios, :key, unique: true
  end
end