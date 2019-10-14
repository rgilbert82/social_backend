class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.boolean :like
      t.boolean :super_like
      t.integer :user_id
      t.integer :post_id
      t.integer :image_id
      t.timestamps
    end
  end
end
