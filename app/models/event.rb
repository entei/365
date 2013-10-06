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
  validates :description, length: {maximum: 140}
# before_save :time_value

  # change event bg color
  def change_color
      self.color || 'rgb(12, 124, 231)'
  end
  
end
