class InvitationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_invitation, only: [:destroy]
    
    def destroy
        #current_user.invitations.find_by(event_id: params[:event_id]).destroy
        @invitation.destroy
        redirect_to calendar_path, notice: "Event was removed" 
    end
    
    private
    
    def set_invitation
        @invitation = Invitation.find(params[:id])
    end
end