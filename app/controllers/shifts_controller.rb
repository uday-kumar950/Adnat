class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :get_org_shift, only: [:index, :create, :update]

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
    @shift.start  = (params[:shift][:date] + " " + params[:shift][:start]).to_time.utc
    @shift.finish  = (params[:shift][:date] + " " + params[:shift][:finish]).to_time.utc
    @shift.user_id  = current_user.id
    shifts = current_user.shifts.where("(start Between ? and  ?) or (finish Between ? and  ?) ",@shift.start,@shift.finish,@shift.start,@shift.finish)
    respond_to do |format|
      if shifts.blank? && @shift.save
         @shifts << @shift
         format.js { redirect_to shifts_path, notice: 'Shift was successfully created.' }
      elsif shifts.present?
         flash[:alert] = "Shift is already present with start and finish time."
         format.js { redirect_to shifts_path} 
      else
         flash[:alert] = "Save failed! #{@shift.errors.full_messages.join(", ")}"
         format.js { redirect_to shifts_path}
      end
    end
  end

  def edit
  end

  def update
    @shift.date = params[:shift][:date]
    @shift.start  = (params[:shift][:date] + " " + params[:shift][:start]).to_time
    @shift.finish  = (params[:shift][:date] + " " + params[:shift][:finish]).to_time
    @shift.break_length = params[:shift][:break_length]
    shifts = current_user.shifts.where("(start Between ? and  ?) or (finish Between ? and  ?) ",@shift.start,@shift.finish,@shift.start,@shift.finish)
    shifts = shifts - [@shift]
    respond_to do |format|
      if shifts.blank? && @shift.save 
         format.js { redirect_to shifts_path, notice: 'Shift was successfully updated.' }
      elsif shifts.present?
         flash[:alert] = "Shift is already present with start and finish time."
         format.js { redirect_to edit_shift_path} 
      else
         flash[:alert] = "Update failed! #{@shift.errors.full_messages.join(", ")}"
         format.js { redirect_to edit_shift_path }
      end
    end
  end

  def destroy
    @shift.destroy
    respond_to do |format|
      format.js { redirect_to shifts_path, notice: 'Organisation was successfully deleted.' }
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
