class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :event_id
      t.string :integer
      t.string :guest_id
      t.string :integer

      t.timestamps
    end
    add_index :invitations, :event_id
    add_index :invitations, :guest_id
    add_index :invitations, [:event_id, :guest_id], unique: true
  end
end
