class InitDatabase < ActiveRecord::Migration[5.1]
  def change

    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps null: false
      t.string :role
      t.attachment :avatar

    end
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :projects do |t|
      t.string :name
      t.string :client
      t.date :end_date
      t.string :status
      t.timestamps
      t.attachment :picture
    end

    create_table :requirements do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.string :suffix
      t.text :description
      t.string :status
      t.date :end_date
      t.string :category
      t.string :level
      t.timestamps
    end

    create_table :comments do |t|
      t.belongs_to :requirement, index: true
      t.belongs_to :user, index: true
      t.text :body
      t.timestamps
    end

    create_table :logs do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.text :operation
      t.timestamps
    end

    create_table :glossaries do |t|
      t.belongs_to :project, index: true
      t.string :key
      t.string :definition
      t.timestamps
    end

    create_table :user_projects do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.boolean :owner, null: false, default: false
    end
    add_index :user_projects, [:project, :user], :unique => true

  end
end