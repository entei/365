class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :current_user#, only: [:edit]

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.build(event_params)
      respond_to do |format|
        if @event.save
          @event.guests << get_reg_users(params[:guests][:email]) if params[:guests][:email]
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
    @guests_emails = @event.guests.map{|g| g.email } * ","
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        if params[:guests][:email]
          @event.invitations.destroy_all # delete all guests
          @event.guests << get_reg_users(params[:guests][:email])
        end
          format.html { redirect_to calendar_path, notice: 'Event was successfully updated.' }
          format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @event = current_user.events.find_by(id: params[:id]) || current_user.shared_events.find(params[:id])
    @owner = User.find(@event.user_id)
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
    params.require(:event).permit(:name, :start_at, :end_at, :user_id, :description, :color, :important, :guests => [])
  end

# Get registered users array from guests
  def get_reg_users(guest_emails)
    g_arr = Array.new
    guest_emails.split(",").each do |e|
      # add user to guests array
      if user = User.find_by(email: e.strip)
       g_arr << user unless user == current_user
      else
        p "User with email #{e} not found"
        # Tell the UserMailer to send a invite after save
        UserMailer.invitation_email(e, current_user, @event).deliver
      end
    end
    g_arr
  end
end
