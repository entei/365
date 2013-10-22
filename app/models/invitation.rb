# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  event_id   :string(255)
#  integer    :string(255)
#  guest_id   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Invitation < ActiveRecord::Base
    belongs_to :guest, class_name: 'User'
    belongs_to :event, class_name: 'Event'
    validates :guest_id, presence: true
    validates :event_id, presence: true
end
