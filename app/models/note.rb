# == Schema Information
#
# Table name: notes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  color       :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Note < ActiveRecord::Base
    belongs_to :user
    validates :title, presence: true
end
