class TopAnalyzer
  
  def initialize(file, options)
    @file = file
    @options = options
    @analysis_status = :idle
  end
  
  def analyze
    timestamps = []
    begin
        while (line = @file.readline)
            line.chomp

            if TopMatcher.new_top?(line)
              current_timestamp = TopMatcher.extract_timestamp(line) 
              timestamps << current_timestamp if analysis_running?(current_timestamp)
            end

            if TopMatcher.info?(line) && analysis_running?(current_timestamp)
              pid = TopMatcher.extract_info(line, :pid)
              name = TopMatcher.extract_info(line, :process_name)
              process = TopProcess.find_or_create(pid,name)
              process.add_info(current_timestamp, TopMatcher.extract_info(line, @options[:target]))
            end
        end
    rescue EOFError
        @file.close
        result = ""
        result <<  "PID," + timestamps.join(",") + "\n"
        result << TopProcess.export_all_to_csv(timestamps, @options[:limit])
    end
    result
  end
  
  private
  
  def analysis_running?(timestamp)
    date_timestamp = ::DateTime.strptime(timestamp, "%H:%M:%S")

    if @analysis_status == :idle
      @analysis_status = :running unless @options[:start_time]
      @analysis_status = :running if @options[:start_time] && date_timestamp > @options[:start_time]
    end
    
    if @analysis_status == :idle || @analysis_status == :running
      @analysis_status = :finished if @options[:end_time] && date_timestamp > @options[:end_time]
    end

    return @analysis_status == :running
  end
  
end