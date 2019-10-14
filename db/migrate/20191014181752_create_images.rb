class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image_url
      t.text :description
      t.boolean :avatar
      t.boolean :background
      t.string :slug
      t.integer :user_id
      t.integer :album_id
      t.integer :post_id
      t.timestamps
    end
  end
end
