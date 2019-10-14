class CreateEventInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :event_invites do |t|
      t.boolean :unread
      t.boolean :rsvp
      t.integer :user_id
      t.integer :event_id
      t.timestamps
    end
  end
end
