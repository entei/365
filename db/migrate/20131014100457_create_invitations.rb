class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :event_id
      t.integer :guest_id

      t.timestamps
    end
    add_index :invitations, :event_id
    add_index :invitations, :guest_id
    add_index :invitations, [:event_id, :guest_id], unique: true
  end
end
