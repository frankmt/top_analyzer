require 'top_process'
require 'top_matcher'

top_file = File.new(ARGV[0])
timestamps = []
begin
    while (line = top_file.readline)
        line.chomp
        
        if TopMatcher.new_top?(line)
          current_timestamp = TopMatcher.extract_timestamp(line) 
          timestamps << current_timestamp
        end
        
        if TopMatcher.info?(line)
          pid = TopMatcher.extract_info(line, :pid)
          name = TopMatcher.extract_info(line, :process_name)
          process = TopProcess.find_or_create(pid,name)
          process.add_info(current_timestamp, TopMatcher.extract_info(line, :memory_percentage))
        end
    end
rescue EOFError
    top_file.close
    $stdout.print "PID," + timestamps.join(",") + "\n"
    $stdout.print TopProcess.export_all_to_csv(timestamps,0.5)
end