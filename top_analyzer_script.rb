top_file = File.new(ARGV[0])

begin
    while (line = top_file.readline)
        line.chomp
        current_ timestamp = TopMatcher.extract_timestamp if TopMatcher.new_top?
        if TopMatcher.info?(line)
          pid = TopMatcher.extract_info(:pid)
          process = TopProcess.find_or_create(pid)
          process.add_info(timestamp, TopMatcher.extract_info(:memory_percentage))
        end
    end
rescue EOFError
    top_file.close
end