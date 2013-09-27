class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :current_user, only: [:edit]
  
  # GET /events/new
  def new
    @event = Event.new 
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.update_attributes(user_id: current_user.id)

    p @event
    respond_to do |format|
    if (@event.end_at >= @event.start_at) && @event.save 
      format.html { redirect_to calendar_path, notice: "Event was successfully created." }
      format.json { render action: 'show', status: :created, location: @event }
    else
      if(@event.start_at && @event.end_at )
         @event.errors.add(:start_at, "date must be less then End date.") if (@event.start_at >= @event.end_at) 
      end
      format.html { render action: 'new' }
      format.json { render json: @event.errors, status: :unprocessable_entity }
    end
  end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params) && (@event.end_at >= @event.start_at)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        if(@event.start_at && @event.end_at )
            @event.errors.add(:start_at, "date must be less then End date.") if (@event.start_at >= @event.end_at) 
        end
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # show event 
  def show
    @user = current_user
  end
  
  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to calendar_path }
      format.json { head :no_content }
    end
  end
  
 private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      # Get only current user events 
      @event = Event.find(params[:id], :conditions => ["user_id = ?", current_user.id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start_at, :end_at, :user_id, :description, :color, :important)
    end
end
