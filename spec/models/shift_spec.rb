require 'rails_helper'

RSpec.describe Shift, type: :model do
    it 'validates presence' do
      record = Shift.new
      record.break_length = nil 
      record.valid? 
      record.errors[:break_length].should include("can't be blank") 

      record.break_length = 10.0 
      record.valid? 
      record.errors[:break_length].should_not include("can't be blank")       
    end

    it 'is valid with valid data' do
      record = Shift.new
      record.start = "Adnat" 
      record.valid?    
      record.errors[:start].should include("should be valid.")

      record.start = "10am" 
      record.valid? 
      record.errors[:start].should_not include("should be valid.") 

      record = Shift.new
      record.finish = "Adnat" 
      record.valid? 
      record.errors[:finish].should include("should be valid.") 

      record.finish = "11am"
      record.valid? 
      record.errors[:finish].should_not include("should be valid.") 
    end

    it 'finish should be greater than start time' do
      record = Shift.new
      record.start = "11am"
      record.finish = "10am" 
      record.break_length = 10
      record.valid?    
      record.errors[:finish].should include("should be greater than start time.")

      record.start = "10am"
      record.finish = "11am" 
      record.valid? 
      record.errors[:finish].should_not include("should be greater than start time.")
    end

    it 'break_length should be less than time_diff_in_min' do
      record = Shift.new
      record.start = "10am"
      record.finish = "11am" 
      record.break_length = 100
      start = record.start.to_time
      finish = record.finish.to_time
      time_diff_in_min = (finish - start) / 60
      record.valid? 
      record.errors[:break_length].should include("should be less than #{time_diff_in_min.to_i} min.")

      record.break_length = 10
      record.valid? 
      record.errors[:break_length].should_not include("should be less than #{time_diff_in_min.to_i} min.")
    end
end
