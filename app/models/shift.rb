class Shift < ApplicationRecord
  belongs_to :user
  validates_presence_of :break_length
  validate :start_finish_time

  def start_finish_time
  	start = self.start.try(:to_time)
  	finish = self.finish.try(:to_time) 
  	errors.add(:start, "should be valid.") if start.blank?
  	errors.add(:finish, "should be valid.") if finish.blank?

  	if start.present? && finish.present?
  		errors.add(:finish, "should be greater than start time.") if start == finish || start > finish
  		time_diff_in_min = (finish - start) / 60
  		errors.add(:break_length, "should be less than #{time_diff_in_min.to_i} min.") if time_diff_in_min < self.break_length && time_diff_in_min > 0
  	end
  end


  def self.time_conversion(minutes)
    hours = minutes / 60
    rest = minutes % 60
    return "#{hours} h #{rest} m" 
  end

end
