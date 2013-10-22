class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  layout 'dashboard'

  def index 
      @notes = current_user.notes.order('created_at DESC').limit(21)
      @note = current_user.notes.new
  end
  
  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.build(note_params)
    
    respond_to do |format| 
      if @note.save
          format.html { redirect_to notes_path, notice: "Note was successfully created." }
          format.json { @note }
          format.js {}
        else
          format.html { render action: 'new' }
          format.json { render json: @note.errors, status: :unprocessable_entity }
          format.js {}
      end
    end
  end

  def edit
  end
  
  def update
      respond_to do |format|
      if @note.update(note_params)
          format.html { redirect_to notes_path, notice: "Note was successfully created." }
          format.json { @note }
          format.js {}
      else
         format.html { render action: 'edit' }
         format.json { render json: @note.errors, status: :unprocessable_entity }
         format.js {}
      end
  end
  end



  def destroy
      @note.destroy
        respond_to do |format|
          format.html { redirect_to notes_path }
          format.json { head :no_content }
          format.js
        end
  end

  def show
 
  end
  
#   def sort
#     JSON.parse(params[:Activity]).each_with_index do |x, index|
#       idx = x["id"]
#       positionx = index+1
#       column = x["column"]
#       activity = Activity.find(idx)
#       activity.update_attributes(:position => positionx, :day_id => column)
#     end
#     render nothing: true
#   end
  
  private 
  
    def set_note
        @note = current_user.notes.find(params[:id])
    end
    
    def note_params
        params.require(:note).permit!
    end
end
