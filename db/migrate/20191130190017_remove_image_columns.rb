class RemoveImageColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :image_id
    remove_column :likes, :image_id
    remove_column :posts, :video
  end
end
