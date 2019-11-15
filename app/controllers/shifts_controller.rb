class ShiftsController < ApplicationController
  #before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :get_org_shift, only: [:index, :create]

  def index    
    @shift = Shift.new
  end

  def show
  end

  def new
    @shift = Shift.new
  end
 
  def create
    @shift = Shift.new(shift_params)
    @shift.start  = params[:shift][:start].to_time
    @shift.finish  = params[:shift][:finish].to_time
    @shift.user_id  = current_user.id
    respond_to do |format|
      if @shift.save
         @shifts << @shift
         format.html { redirect_to shifts_path, notice: 'Shift was successfully created.' }
      else
         flash[:alert] = "Save failed! #{@shift.errors.full_messages.join(", ")}"
         format.html { redirect_to shifts_path}
      end
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    def get_org_shift
      @shifts = current_user.organisation.shifts
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:user_id,:organisation_id, :date, :start, :finish, :break_length)
    end
end
