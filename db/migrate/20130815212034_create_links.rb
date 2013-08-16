class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :user_id
      t.string :title
      t.string :url
      t.text :desc
      t.integer :sub_id

      t.timestamps
    end
    add_index :links, :user_id
    add_index :links, :sub_id
  end
end
