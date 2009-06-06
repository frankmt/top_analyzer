require 'top_analyzer'
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
  puts opts.help
else  
  opts.parse!(ARGV)
  top_file = File.new(ARGV[0])
  
  analyzer = TopAnalyzer.new(top_file,options)
  $stdout.print analyzer.analyze
end