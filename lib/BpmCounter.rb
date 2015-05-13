class BpmCounter
  def initialize(threshold)
    @tick_interval_quarter_notes = 0
    @timestamps = Array.new
    @threshold = threshold
    @counter = 0
    @logger = MyLogger.instance
    @bpm=0
    @first_run = true
    @delta = 0
    @last_timestamp=0
    @new_timestamp=0
    @bpm_average = "Unknown"
  end
  def get_interval
    @tick_interval_quarter_notes
  end
  
  def log_bpm
    @logger.debug("Current bpm (without threshold) is: #{@bpm.round(2)}")
  end
  
  def log_bpm_average
    @logger.debug("Current average bpm (with threshold #{@threshold}) is: #{@bpm_average.round(2)}")
  end
  
  def update(current_timestamp)
    @tick_interval_quarter_notes = (@last_timestamp-current_timestamp).abs
    if @first_run
      @last_timestamp = 0
      @new_timestamp = current_timestamp
      @first_run = false
      @bpm = 0
      @bpm_average=0
    else
    @last_timestamp = @new_timestamp
    @new_timestamp = current_timestamp
    @delta = @new_timestamp - @last_timestamp
    calculate_bpm
    calculate_bpm_average(@threshold)
    end
  end
    
  def calculate_bpm
    quarter_note = @delta.to_f * 24.to_f
    @bpm = 60000 / quarter_note
  end
  
  def calculate_bpm_average(threshold)
    @counter +=1
    if @counter<=threshold
      @timestamps.push(@bpm)
      sum = @timestamps.inject(:+)
      @bpm_average = sum.to_f/@timestamps.size.to_f
    else
      @timestamps.delete_at(0)
      @timestamps.push(@bpm)
      sum = @timestamps.inject(:+)
      @bpm_average = sum.to_f/threshold.to_f
    end
  end
  
end