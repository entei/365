# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  start_at    :datetime
#  end_at      :datetime
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  color       :string(255)
#  place       :string(255)
#  important   :boolean          default(FALSE)
#  notice      :string(255)
#

class Event < ActiveRecord::Base
  has_event_calendar
  belongs_to :user
  validates :start_at, :end_at, :name, presence: true
#   before_save :time_value
  # event bg color
  def color
     self[:color] || '#9999FF'
  end
  
#   def time_value
#     if self[:start_at] > self[:end_at]
        
#     end
#   end
end
