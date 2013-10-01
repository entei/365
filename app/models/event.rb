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
  
  def self.today_events(user)
      today = Time.current.in_time_zone(user.timezone)
      end_of_today = Time.current.end_of_day.in_time_zone(user.timezone)
      Event.where("end_at >= ? AND start_at < ? AND user_id = ?", today, end_of_today, user.id)
  end
  
  def self.events_left(user)
    cur_time = Time.now.in_time_zone(user.timezone)
    Event.where("end_at > ? AND user_id =? ", cur_time, user.id)
  end

end
