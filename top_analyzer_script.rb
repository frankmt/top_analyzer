require 'top_process'
require 'top_matcher'
require 'optparse'

options = {}

opts = OptionParser.new do |opts|
  opts.banner = <<-DESC
  
  Top Analyzer
  =================================
  
  Prints to stdout a csv file containing information extracted from a batch top output
  Developed against top: procps version 3.2.7
  
  Usage: ruby top_analyzer FILE [OPTIONS]

  DESC

  options[:target] = :memory_percentage
  opts.on( '-t', '--target=TARGET', <<-DESC ) do |target|
    monitoring target
      Defines which variable from the top command will be analyzed
      Current TARGET options are:
      m - memory percentage      
    DESC
    
    case target
    when "m"
      options[:target] = :memory_percentage
    else
      options[:target] = :memory_percentage
    end
  end

  options[:limit] = 0
  opts.on( '-l', '--limit=LIMIT', <<-DESC ) do |limit|
    monitoring lower limit
      If this variable is set processes that have all samples lower 
      than LIMIT won't be returned in the output.
    DESC
    options[:limit] = limit.to_f
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

if (ARGV.empty?) 
  puts "hey"
else  
  opts.parse!(ARGV)
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
            process.add_info(current_timestamp, TopMatcher.extract_info(line, options[:target]))
          end
      end
  rescue EOFError
      top_file.close
      $stdout.print "PID," + timestamps.join(",") + "\n"
      $stdout.print TopProcess.export_all_to_csv(timestamps, options[:limit])
  end
end