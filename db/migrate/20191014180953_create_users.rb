class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.string :location
      t.string :tagline
      t.text :description
      t.string :token
      t.string :slug
      t.boolean :admin
      t.timestamps
    end
  end
end
