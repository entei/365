class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :current_user#, only: [:edit]
  
  def new
    @event = current_user.events.new 
  end

  def create
    @event = current_user.events.build(event_params)
        respond_to do |format|
            if @event.save 
                @event.guests << get_reg_users(params[:guests][:email])
                format.html { redirect_to calendar_path, notice: "Event was successfully created." }
                format.json { render action: 'show', status: :created, location: @event }
            else
                format.html { render action: 'new' }
                format.json { render json: @event.errors, status: :unprocessable_entity }
            end
        end
  end
  
  def edit
    @start_at = @event.start_at
    @end_at = @event.end_at
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to calendar_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    #@user = current_user
  end
  
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
      @event = current_user.events.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start_at, :end_at, :user_id, :description, :color, :important)
    end
    
    # Get registered users array from guests
    def get_reg_users(guest_emails)
        g_arr = Array.new
        guest_emails.split(",").each do |e|
            # add user to guests array
            if user = User.find_by(email: e.strip)
                g_arr << user
            else
               p "User with email #{e} not found"
               # send email invite
            end
        end
        g_arr
    end
end
