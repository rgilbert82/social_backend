class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :post_id
      t.integer :image_id
      t.integer :event_id
      t.integer :user_id
      t.timestamps
    end
  end
end
