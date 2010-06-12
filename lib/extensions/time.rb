# Add workday and weekday concepts to the Time class
class Time
  class << self
    
    # Checks if time is during business hours
    def during_business_hours?(time)
      workday?(time) && !before_business_hours?(time) && !after_business_hours?(time)
    end

  end

  def business_seconds_duration_to(time)
    if time.to_date == self.to_date
    end
    time_left = 0
    start_day = self
    while start_day.to_date < time.to_date
      parsed_start_day = Time.parse(start_day.to_s)
      time_left += start_day.business_seconds_left_to_the_end_of_day
      start_day = Time.beginning_of_workday(parsed_start_day) + 1.day
    end
    time_left += time.business_seconds_from_the_beginning_of_day
    time_left
  end

  def business_seconds_left_to_the_end_of_day
    time = Time.parse(self.to_s)
    if Time.during_business_hours?(time)
      Time.end_of_workday(time) - self
    elsif Time.before_business_hours?(time)
      Time.end_of_workday(time) - Time.beginning_of_workday(time)
    else
      0
    end
  end

  def business_seconds_from_the_beginning_of_day
    time = Time.parse(self.to_s)
    if Time.during_business_hours?(time)
      self - Time.beginning_of_workday(time)
    elsif Time.after_business_hours?(time)
      Time.end_of_workday(time) - Time.beginning_of_workday(time)
    else
      0
    end
  end

end
