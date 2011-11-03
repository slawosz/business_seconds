class Time
  class << self

    # Checks if time is during business hours
    def during_business_hours?(time)
      workday?(time) && !before_business_hours?(time) && !after_business_hours?(time)
    end

    def business_seconds_from_the_beginning_of_day(time)
      time =  Time.zone ? Time.zone.parse(time.to_s) : time
      if during_business_hours?(time)
        time - beginning_of_workday(time)
      elsif after_business_hours?(time)
        end_of_workday(time) - beginning_of_workday(time)
      else
        0
      end
    end

    def business_seconds_left_to_the_end_of_day(time)
      time =  Time.zone ? Time.zone.parse(time.to_s) : time
      if during_business_hours?(time)
        end_of_workday(time) - time
      elsif before_business_hours?(time)
        end_of_workday(time) - beginning_of_workday(time)
      else
        0
      end
    end

    def business_seconds_duration_from_to(start_time, end_time)
      start_time =  Time.zone ? Time.zone.parse(start_time.to_s) : start_time
      end_time =  Time.zone ? Time.zone.parse(end_time.to_s) : end_time
      if start_time > end_time
        return 0
      end
      if end_time.to_date == start_time.to_date
        return business_seconds_from_the_beginning_of_day(end_time) - business_seconds_from_the_beginning_of_day(start_time)
      end
      time_left = 0
      start_day = start_time
      while start_day.to_date < end_time.to_date
        parsed_start_day = Time.parse(start_day.to_s)
        time_left += business_seconds_left_to_the_end_of_day(start_day)
        start_day = beginning_of_workday(parsed_start_day) + 1.day
      end
      time_left += business_seconds_from_the_beginning_of_day(end_time)
      time_left
    end

  end

end
