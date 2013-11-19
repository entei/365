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
  
  has_many :invitations, foreign_key: "event_id", dependent: :destroy
  has_many :guests, through: :invitations, source: :guest

  validates :start_at, :end_at, :name, presence: true
  validates :description, length: {maximum: 140}
  validates :user_id, presence: true
  validate :check_date

  scope :today, ->(now, day_end) { where("end_at >= ? AND start_at < ?", now, day_end) }
  scope :left, ->(now) { where("end_at > ?", now)}

  # change event bg color
  def change_color
    self.color || 'rgb(12, 124, 231)'
  end
  
  # Start_at less then end_at
  def check_date
    if start_at.present? && end_at.present?
      errors.add(:start_at, "must be less then end date") if self.start_at > self.end_at
    end
  end
  
end
