class CalendarController < ApplicationController
    before_filter :authenticate_user!
  def index
    @first_day_of_week = 1
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    
   @event_strips = Event.event_strips_for_month(@shown_month, @first_day_of_week)  #all events
   if current_user
     # show only current user events
	   @event_strips = current_user.events.event_strips_for_month(@shown_month, @first_day_of_week) 
   else
    
   end
  end

  def show
  	@month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @event_strips = Event.event_strips_for_month(@shown_month, @first_day_of_week)
  end
  
end
