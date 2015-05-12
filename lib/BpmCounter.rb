class BpmCounter
  def initialize(threshold)
    @threshold = threshold
    @counter = 0
    @logger = MyLogger.instance
    @bpm=0
    @first_run = true
    @delta = 0
    @last_timestamp=0
    @new_timestamp=0
    @bpm_average = "Unknown"
    @bpm_sum=0
  end
  
  def log_bpm
    @logger.debug("Current bpm (without threshold) is: #{@bpm}")
  end
  def log_bpm_average
    @logger.debug("Current average bpm (with threshold #{@threshold}) is: #{@bpm_average}")
  end
  
  def update(current_timestamp)
    if @first_run
      @last_timestamp = 0
      @new_timestamp = current_timestamp
      @first_run = false
      @bpm = 0
    else
    @last_timestamp = @new_timestamp
    @new_timestamp = current_timestamp
    @delta = @new_timestamp - @last_timestamp
    calculate_bpm
    calculate_bpm_average(@threshold)
    end
  end
  
  def reset
    @counter = 0
    @bpm=0
    @first_run = true
    @delta = 0
    @last_timestamp=0
    @new_timestamp=0
    @bpm_average = "Unknown"
    @bpm_sum=0
  end
  
  def calculate_bpm
    quarter_note = @delta.to_f * 24.to_f
    @bpm = 60000 / quarter_note
  end
  
  def calculate_bpm_average(threshold)
    @counter +=1
    if @counter<=threshold
      @bpm_sum += @bpm
    else
      @bpm_average = @bpm_sum.to_f/threshold.to_f
      @counter = 0
      @bpm_sum = 0
    end
  end
  
end