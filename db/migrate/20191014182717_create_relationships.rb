class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.string :type
      t.boolean :confirmed
      t.integer :user_id
      t.integer :relation_id
      t.timestamps
    end
  end
end
