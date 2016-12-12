class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.text :content, null: false
      t.boolean :private, null: false, default: false
      t.boolean :completed, null: false, default: false

      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
