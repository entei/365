class CalendarController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @first_day_of_week = 1
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
  # @event_strips = Event.event_strips_for_month(@shown_month, @first_day_of_week)  #all users events
   
    #show all current_user events
    events = current_user.events.event_strips_for_month(@shown_month, @first_day_of_week) 
    shared_events = current_user.shared_events.event_strips_for_month(@shown_month, @first_day_of_week) 
    @event_strips = events + shared_events
  end

end
