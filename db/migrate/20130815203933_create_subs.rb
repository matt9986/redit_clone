class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.integer :mod_id
      t.string :name

      t.timestamps
    end
    add_index :subs, :mod_id
  end
end
