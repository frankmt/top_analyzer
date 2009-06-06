class TopAnalyzer
  
  def initialize(file, options)
    @file = file
    @options = options
  end
  
  def analyze
    timestamps = []
    begin
        while (line = @file.readline)
            line.chomp

            if TopMatcher.new_top?(line)
              current_timestamp = TopMatcher.extract_timestamp(line) 
              timestamps << current_timestamp
            end

            if TopMatcher.info?(line)
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
  
end